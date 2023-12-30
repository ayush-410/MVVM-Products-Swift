//
//  Constant.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 26/09/23.
//


enum Constant {
    enum API {
        static let productURL = "https://fakestoreapi.com/products"
    }
}

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(_ error: Error?)
}
