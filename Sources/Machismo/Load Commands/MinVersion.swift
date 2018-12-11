//
//  MinVersion.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-13.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation
import MachO

extension LoadCommand {
	public struct MinVersion: LoadCommandType {
		public enum Platform {
			case iOS
			case macOS
			case tvOS
			case watchOS
		}
		let platform: Platform
		let version: SemanticVersion
		let sdk: SemanticVersion
		init(loadCommand: LoadCommand) {
			var command = loadCommand.data.extract(version_min_command.self, offset: loadCommand.offset)
			if loadCommand.byteSwapped {
				swap_version_min_command(&command, byteSwappedOrder)
			}
			self.platform = {
				switch Int32(command.cmd) {
				case LC_VERSION_MIN_IPHONEOS:
					return .iOS
				case LC_VERSION_MIN_MACOSX:
					return .macOS
				case LC_VERSION_MIN_TVOS:
					return .tvOS
				case LC_VERSION_MIN_WATCHOS:
					return .watchOS
				default:
					fatalError("Unknown Platform")
				}
			}()
			self.version = SemanticVersion(command.version)
			self.sdk = SemanticVersion(command.sdk)
		}
	}
}
