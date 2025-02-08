//
//  ImageExtension.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit
import Kingfisher

extension ProductModel {
    var productImage: UIImage {
        return UIImage(named: "placeholder") ?? UIImage()
    }

    @MainActor func loadProductImage(into imageView: UIImageView) {
        guard let imageUrl = image, let url = URL(string: imageUrl) else {
            imageView.image = productImage
            return
        }
        imageView.kf.setImage(with: url, placeholder: productImage)
    }
}
