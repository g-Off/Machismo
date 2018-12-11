//
//  MachO.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-12.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation

public struct MachOFile {
	public enum Architecture {
		case i386
		case x86_64
	}
	
	let url: URL
	let header: Header
	let commands: [LoadCommandType]
	
	public init(url: URL) throws {
		let data = try Data(contentsOf: url)
		try self.init(url: url, data: data)
	}
	
	public init(url: URL, data: Data) throws {
		self.url = url
		
		let dataSlice: Data
		if let fatHeader = FatHeader(data: data) {
			let arch = fatHeader.architectures.first { $0.cputype == CPU_TYPE_X86_64 }!
			dataSlice = data[arch]
		} else {
			dataSlice = data
		}
		
		let attributes = MachOFile.machAttributes(from: dataSlice)
		let header = MachOFile.header(from: dataSlice, attributes: attributes)
		
		self.header = header
		self.commands = MachOFile.segmentCommands(from: dataSlice, header: header, attributes: attributes)
	}
	
	private struct MachAttributes {
		let is64Bit: Bool
		let isByteSwapped: Bool
	}
	private static func machAttributes(from data: Data) -> MachAttributes {
		let magic = data.extract(UInt32.self)
		let is64Bit = magic == MH_MAGIC_64 || magic == MH_CIGAM_64
		let isByteSwapped = magic == MH_CIGAM || magic == MH_CIGAM_64
		return MachAttributes(is64Bit: is64Bit, isByteSwapped: isByteSwapped)
	}
	
	private static func header(from data: Data, attributes: MachAttributes) -> Header {
		if attributes.is64Bit {
			let header = data.extract(mach_header_64.self)
			return Header(header: header)
		} else {
			let header = data.extract(mach_header.self)
			return Header(header: header)
		}
	}
	
	private static func segmentCommands(from data: Data, header: Header, attributes: MachAttributes) -> [LoadCommandType] {
		var segmentCommands: [LoadCommandType] = []
		var offset = header.size
		for _ in 0..<header.loadCommandCount {
			let loadCommand = LoadCommand(data: data, offset: offset, byteSwapped: attributes.isByteSwapped)
			if let command = loadCommand.command(from: data, offset: offset, byteSwapped: attributes.isByteSwapped) {
				segmentCommands.append(command)
			}
			offset += Int(loadCommand.size)
		}
		return segmentCommands
	}
	
	var rpaths: [String] {
		return commands.compactMap { $0 as? LoadCommand.RPath }.map { $0.path }
	}
	
	var dylibs: [Dylib] {
		return commands.compactMap { $0 as? LoadCommand.LoadDylib }.map { $0.dylib }
	}
}
