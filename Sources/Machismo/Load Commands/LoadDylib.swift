//
//  LoadDylib.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-12.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation
import MachO

struct Dylib {
//	public var name: lc_str /* library's path name */
//	public var timestamp: UInt32 /* library's build time stamp */
//	public var current_version: UInt32 /* library's current version number */
//	public var compatibility_version: UInt32 /* library's compatibility vers number*/
	
	public let name: String
	public let timestamp: Date
	public let currentVersion: SemanticVersion
	public let compatibilityVersion: SemanticVersion
	
	init(loadCommand: LoadCommand, dylib: dylib) {
		self.name = String(loadCommand: loadCommand, string: dylib.name)
		self.timestamp = Date(timeIntervalSince1970: Double(dylib.timestamp))
		self.currentVersion = SemanticVersion(dylib.current_version)
		self.compatibilityVersion = SemanticVersion(dylib.compatibility_version)
	}
}

extension LoadCommand {
	public struct LoadDylib: LoadCommandType {
		public let dylib: Dylib
		
		init(loadCommand: LoadCommand) {
			var command = loadCommand.data.extract(dylib_command.self, offset: loadCommand.offset)
			if loadCommand.byteSwapped {
				swap_dylib_command(&command, byteSwappedOrder)
			}
			self.dylib = Dylib(loadCommand: loadCommand, dylib: command.dylib)
		}
	}
}
