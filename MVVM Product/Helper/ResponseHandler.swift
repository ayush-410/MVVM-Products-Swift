//
//  ResponseHandler.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 29/09/23.
//

import Foundation

class ResponseHandler {
    
    func decodeResponseData<T:Codable>(data: Data, modelType: T.Type, completion: @escaping (Result<T,DataError>) -> Void) {
        do {
            let products = try JSONDecoder().decode(modelType, from: data)
            completion(.success(products))
        } catch {
            completion(.failure(.network(error)))
        }
    }
}
