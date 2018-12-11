//
//  AdjacencyList.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-13.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation

final class AdjacencyListGraph<T: Hashable> {
	private var adjacencyList: [Vertex<T>: [Edge<T>]] = [:]
	
	public init() {
		
	}
	
	func addVertex(_ data: T) -> Vertex<T> {
		if let vertex = adjacencyList.first(where: { $0.key.data == data })?.key {
			return vertex
		}
		let vertex = Vertex(data: data)
		adjacencyList[vertex] = []
		return vertex
	}
	
	func addEdge(from: Vertex<T>, to: Vertex<T>, weight: Double? = nil) {
		let edge = Edge(from: from, to: to, weight: weight)
		adjacencyList[from, default: []].append(edge)
	}
	
	func dotRepresentation(name: String) -> String {
		var lines: [String] = []
		lines.append("digraph \(name) {")
		for (vertex, edges) in adjacencyList {
			lines.append("\t\"\(vertex)\";")
			for edge in edges {
				lines.append("\t\"\(edge.from)\" -> \"\(edge.to)\";")
			}
		}
		lines.append("}")
		return lines.joined(separator: "\n")
	}
}

extension AdjacencyListGraph {
//	var description: String {
//		var rows: [String] = []
//		for edgeList in adjacencyList {
//			guard let edges = edgeList.edges else {
//				continue
//			}
//
//			var row = [String]()
//			for edge in edges {
//				var value = "\(edge.to.data)"
//				if edge.weight != nil {
//					value = "(\(value): \(edge.weight!))"
//				}
//				row.append(value)
//			}
//			rows.append("\(edgeList.vertex.data) -> [\(row.joined(separator: ", "))]")
//		}
//
//		return rows.joined(separator: "\n")
//	}
}
