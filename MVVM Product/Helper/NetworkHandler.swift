//
//  NetworkHandler.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 29/09/23.
//

import Foundation

class NetworkHandler {
    
    func sendNetworkRequest(request: URLRequest, completion: @escaping (Result<Data,DataError>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            completion(.success(data))
        }
        task.resume()
        
    }
}
