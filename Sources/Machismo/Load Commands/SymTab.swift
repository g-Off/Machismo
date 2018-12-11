//
//  SymTab.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-16.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation
import MachO

extension LoadCommand {
	public struct SymTab: LoadCommandType {
		
		init(loadCommand: LoadCommand) {
			var command = loadCommand.data.extract(symtab_command.self, offset: loadCommand.offset)
			if loadCommand.byteSwapped {
				swap_symtab_command(&command, byteSwappedOrder)
			}
		}
	}
}
