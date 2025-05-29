//
//  EndPointType.swift
// 
//
//  Created by Vinsi.
//

import Foundation

protocol EndPointType {
    associatedtype Response: Decodable
    var request: RequestBuilder { get }
}


