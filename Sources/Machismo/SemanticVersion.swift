//
//  SemanticVersion.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-13.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation

public struct SemanticVersion {
	public var majorVersion: Int
	public var minorVersion: Int
	public var patchVersion: Int
	public init() {
		self.init(majorVersion: 0, minorVersion: 0, patchVersion: 0)
	}
	
	public init(majorVersion: Int, minorVersion: Int, patchVersion: Int) {
		self.majorVersion = majorVersion
		self.minorVersion = minorVersion
		self.patchVersion = patchVersion
	}
	
	init(_ value: UInt32) {
		self.init(
			majorVersion: Int(value >> 16),
			minorVersion: Int(value >> 8) & 0xFF,
			patchVersion: Int(value) & 0xFF
		)
	}
}
