//
//  EndPoint.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 27/09/23.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
    var header: [String:String]? { get }
}


