//
//  ProductViewModel.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 26/09/23.
//

import Foundation

final class ProductViewModel {
    
    var products = [Product]()
    var eventHandler: ((Event) -> Void)?
    func fetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: [Product].self,
            type: ProductEndPointItems.products) { [weak self] response in
                guard let self else {
                    return
                }
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let products):
                    self.products = products
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    func addProducts(parameters: AddProductModel) {
        APIManager.shared.request(modelType: AddProductModel.self, type: ProductEndPointItems.AddProducts(product: parameters)) { result in
            switch result {
            case .success(let product):
                self.eventHandler?(.newProductAdded(product: product))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(_ error: Error?)
        case newProductAdded(product: AddProductModel)
    }
}
