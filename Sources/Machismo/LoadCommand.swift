//
//  LoadCommand.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-06.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation

protocol LoadCommandType {
	
}

struct LoadCommand {
	let command: UInt32
	let size: Int
	
	let data: Data
	let offset: Int
	let byteSwapped: Bool
	
	init(data: Data, offset: Int, byteSwapped: Bool) {
		var loadCommand = data.extract(load_command.self, offset: offset)
		if byteSwapped {
			swap_load_command(&loadCommand, byteSwappedOrder)
		}
		self.command = loadCommand.cmd
		self.size = Int(loadCommand.cmdsize)
		self.data = data
		self.offset = offset
		self.byteSwapped = byteSwapped
	}
	
	func command(from data: Data, offset: Int, byteSwapped: Bool) -> LoadCommandType? {
		switch Int(command) {
		case Int(LC_SEGMENT), Int(LC_SEGMENT_64):
			return Segment(loadCommand: self)
		case Int(LC_RPATH):
			return RPath(loadCommand: self)
		case Int(LC_LOAD_DYLIB):
			return LoadDylib(loadCommand: self)
		case Int(LC_VERSION_MIN_IPHONEOS), Int(LC_VERSION_MIN_MACOSX), Int(LC_VERSION_MIN_TVOS), Int(LC_VERSION_MIN_WATCHOS):
			return MinVersion(loadCommand: self)
		case Int(LC_SYMTAB):
			return SymTab(loadCommand: self)
		default:
			return nil
		}
	}
}
