//
//  Vertex.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-13.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation

public struct Vertex<T: Hashable>: Hashable {
	var data: T
}

extension Vertex: CustomStringConvertible {
	public var description: String {
		return "\(data)"
	}
}
