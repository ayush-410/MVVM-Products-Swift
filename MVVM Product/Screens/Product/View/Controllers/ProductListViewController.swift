//
//  ProductListViewController.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 26/09/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    private let viewModel = ProductViewModel()
    @IBOutlet weak var productTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }
    
    func configuration() {
        initViewModel()
        observeEvent()
        productTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .loading:
                // start the loader
                print("Loading Products...")
            case .stopLoading:
                // stop the loader
                print("Stop Loading...")
            case .dataLoaded:
                print("Data Loaded...")
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error as Any)
            case .newProductAdded(let product):
                print(product)
            }
            
        }
        
    }
    
    @IBAction func addProductBtnTapped(_ sender: UIBarButtonItem) {
        let product = AddProductModel(title: "iPhone 15")
        viewModel.addProducts(parameters: product)
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
    
}
