//
//  MachismoTests.swift
//  MachismoTests
//
//  Created by Geoffrey Foster on 2018-05-04.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import XCTest
@testable import Machismo

class MachismoTests: XCTestCase {
	let url = URL(fileURLWithPath: "/Applications/Xcode.app/Contents/MacOS/Xcode")
//	func testRead() throws {
//		let parser = try Parser(url: url)
//		XCTAssertTrue(parser.is64Bit)
//		XCTAssertFalse(parser.byteSwapped)
//		parser.parseHeader()
//		//parser.parseSegmentCommands()
//	}
	
	func testFat() throws {
		//let machFile = try MachOFile(url: URL(fileURLWithPath: "/System/Library/Frameworks/Cocoa.framework/Versions/A/Cocoa"))
		let machFile = try MachOFile(url: URL(fileURLWithPath: "/Applications/Xcode.app/Contents/MacOS/Xcode"))
		print("hello")
	}
	
	func testGraph() throws {
		var graph = try MachOGraph(executableURL: url)
		print("hello")
		let dot = graph.graph.dotRepresentation(name: "\"\(url.path)\"")
		print(dot)
	}
}
