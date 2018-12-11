//
//  MachOGraph.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-13.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation

class MachOGraph {
	var binaries: [URL: MachOFile] = [:]
	let executableURL: URL
	
	let graph = AdjacencyListGraph<URL>()
	
	init(executableURL: URL) throws {
		self.executableURL = executableURL
		
		try load(url: executableURL)
	}
	
	func load(url: URL) throws {
		guard binaries[url] == nil else { return }
		let binary = try MachOFile(url: url)
		binaries[url] = binary
		
		let fromVertex = graph.addVertex(url)
		
		let loaderExecutablePath = "@executable_path/"
		let rpaths: [URL] = binary.rpaths.compactMap {
			if $0.hasPrefix(loaderExecutablePath) {
				let path = $0.dropFirst(loaderExecutablePath.count)
				return URL(fileURLWithPath: String(path), relativeTo: executableURL)
			}
			return nil
		}
		
		
		let dylibURLs: [URL] = binary.dylibs.compactMap {
			return path(for: $0, rpaths: rpaths)
		}
		
		try dylibURLs.forEach {
			let toVertex = graph.addVertex($0)
			graph.addEdge(from: fromVertex, to: toVertex)
			try load(url: $0)
		}
	}
	
	private func path(for dylib: Dylib, rpaths: [URL]) -> URL? {
		let loaderRPath = "@rpath/"
		if dylib.name.hasPrefix(loaderRPath) {
			for rpath in rpaths {
				let path = dylib.name.dropFirst(loaderRPath.count)
				let potentialURL = URL(fileURLWithPath: String(path), relativeTo: rpath)
				if let reachable = try? potentialURL.checkResourceIsReachable(), reachable {
					return potentialURL
				}
			}
			return nil
		} else {
			return URL(fileURLWithPath: dylib.name)
		}
	}
}
