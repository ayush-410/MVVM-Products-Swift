//
//  AddProductViewController.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 28/09/23.
//

import UIKit

class AddProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addProduct()
    }
    
    func addProduct() {
        
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        let parameter = AddProductModel(title: "BMW Car")
        request.httpBody = try? JSONEncoder().encode(parameter)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                return
            }
            do {
                let productResponse = try JSONDecoder().decode(AddProductModel.self, from: data)
                debugPrint(productResponse)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }.resume()
        
    }
    

}
