//
//  APIManager.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 26/09/23.
//

import Foundation

//typealias Handler = (Result<[Product], DataError>) -> Void

typealias Handler<T> = (Result<T,DataError>) -> Void

final class APIManager {
    
    let networkHandler: NetworkHandler
    let responseHandler: ResponseHandler
    static let shared = APIManager(networkHandler: NetworkHandler(), responseHandler: ResponseHandler())
    
    init(networkHandler: NetworkHandler, responseHandler: ResponseHandler) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    //    func fetchProducts(completion: @escaping Handler) {
    //        guard let url = URL(string: Constant.API.productURL) else {
    //            completion(.failure(.invalidURL))
    //            return
    //        }
    //        let session = URLSession.shared
    //        let task = session.dataTask(with: url) { data, response, error in
    //            guard let data, error == nil else {
    //                completion(.failure(.invalidData))
    //                return
    //            }
    //            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
    //                completion(.failure(.invalidResponse))
    //                return
    //            }
    //            do {
    //                let products = try JSONDecoder().decode([Product].self, from: data)
    //                completion(.success(products))
    //            } catch {
    //                completion(.failure(.network(error)))
    //
    //            }
    //        }
    //        task.resume()
    //    }
    
    // Generic function for get and post request
    
    func request<T:Codable>(
        modelType: T.Type,
        type: EndPointType, completion: @escaping Handler<T>) {
            guard let url = type.url else {
                completion(.failure(.invalidURL))
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = type.method.rawValue
            if let parameters = type.body {
                request.httpBody = try? JSONEncoder().encode(parameters)
            }
            request.allHTTPHeaderFields = type.header
            networkHandler.sendNetworkRequest(request: request) { result in
                switch result {
                case .success(let data):
                    self.responseHandler.decodeResponseData(data: data, modelType: modelType) { mainResponse in
                        switch mainResponse {
                        case .success(let products):
                            completion(.success(products))
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
    static var commonHeaders: [String:String] {
        return [
            "Content-Type" : "application/json"
        ]
    }
}
