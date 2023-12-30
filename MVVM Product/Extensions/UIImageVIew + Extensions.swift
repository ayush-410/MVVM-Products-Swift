//
//  UIImageVIew + Extensions.swift
//  MVVM Product
//
//  Created by Ayush Kumar Singh on 27/09/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
