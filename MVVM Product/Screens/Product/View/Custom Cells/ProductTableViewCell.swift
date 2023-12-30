//
//  ProductTableViewCell.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 27/09/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productRatingBtn: UIButton!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productCost: UILabel!
    
    var product: Product? {
        didSet {
            configureProduct()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productBackgroundView.clipsToBounds = false
        productBackgroundView.layer.cornerRadius = 15
        productImage.layer.cornerRadius = 10
        productBackgroundView.backgroundColor = .systemGray6
        
    }

    private func configureProduct() {
        guard let product else {
            return
        }
        productTitle.text = product.title
        productCategory.text = product.category
        productDescription.text = product.description
        productRatingBtn.setTitle("\(product.rating.rate)", for: .normal)
        productCost.text = "$\(product.price)"
        productImage.setImage(urlString: product.image)
        
    }
    
    
}
