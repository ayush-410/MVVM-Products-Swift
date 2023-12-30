//
//  ProductEndPoint.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 28/09/23.
//

import Foundation

enum ProductEndPointItems {
    case products
    case AddProducts(product: AddProductModel)
}

extension ProductEndPointItems : EndPointType {
    
    var baseURL: String {
        return "https://fakestoreapi.com/"
    }
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case .AddProducts:
            return "products"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        case .AddProducts:
            return .post
        }
    }
    
    var body: Encodable? {
        switch self {
        case .products:
            return nil
        case .AddProducts(let product):
            return product
        }
    }
    
    var header: [String : String]? {
        return APIManager.commonHeaders
    }
}
