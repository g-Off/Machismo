//
//  Data+Extensions.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-13.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation

extension Data {
	subscript(_ arch: FatHeader.Architecture) -> Data {
		return Data(self[arch.offset..<(arch.offset + arch.size)])
	}
	
	func extract<T>(_ type: T.Type, offset: Int = 0) -> T {
//		let ptr = UnsafeMutablePointer<T>.allocate(capacity: 1)
		let data = self[offset..<offset + MemoryLayout<T>.size]
		return data.withUnsafeBytes { (pointer: UnsafePointer<UInt8>) -> T in
			pointer.withMemoryRebound(to: T.self, capacity: 1, { (p) -> T in
				return p.pointee
			})
		}
	}
}
