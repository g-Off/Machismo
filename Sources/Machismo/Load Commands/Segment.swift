//
//  Segment.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-06.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation
import MachO

extension LoadCommand {
	public struct Segment: LoadCommandType {
		
		//	public var cmd: UInt32 /* for 64-bit architectures */ /* LC_SEGMENT_64 */
		//	public var cmdsize: UInt32 /* includes sizeof section_64 structs */
		//	public var segname: (Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8, Int8) /* segment name */
		//	public var vmaddr: UInt64 /* memory address of this segment */
		//	public var vmsize: UInt64 /* memory size of this segment */
		//	public var fileoff: UInt64 /* file offset of this segment */
		//	public var filesize: UInt64 /* amount to map from the file */
		//	public var maxprot: vm_prot_t /* maximum VM protection */
		//	public var initprot: vm_prot_t /* initial VM protection */
		//	public var nsects: UInt32 /* number of sections in segment */
		//	public var flags: UInt32 /* flags */
		
		public let name: String
		
		init(command: segment_command_64) {
			self.name = String(command.segname)
		}
		
		init(command: segment_command) {
			self.name = String(command.segname)
		}
		
		init(loadCommand: LoadCommand) {
			if loadCommand.command == LC_SEGMENT_64 {
				var segmentCommand = loadCommand.data.extract(segment_command_64.self, offset: loadCommand.offset)
				if loadCommand.byteSwapped {
					swap_segment_command_64(&segmentCommand, byteSwappedOrder)
				}
				self.init(command: segmentCommand)
			} else {
				var segmentCommand = loadCommand.data.extract(segment_command.self, offset: loadCommand.offset)
				if loadCommand.byteSwapped {
					swap_segment_command(&segmentCommand, byteSwappedOrder)
				}
				self.init(command: segmentCommand)
			}
		}
	}
}
