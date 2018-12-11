//
//  Edge.swift
//  Machismo
//
//  Created by Geoffrey Foster on 2018-05-13.
//  Copyright © 2018 g-Off.net. All rights reserved.
//

import Foundation

public struct Edge<T>: Equatable where T: Hashable {
	public var from: Vertex<T>
	public var to: Vertex<T>
	public let weight: Double?
}
