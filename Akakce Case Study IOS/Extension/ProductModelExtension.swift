//
//  RatingExtension.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit
import Kingfisher

extension ProductModel {
    var getProductRatingLabel: String {
        if let rating = self.rating?.rate {
            return String(format: "%.1f/5.0", rating)
        } else {
            return "No ratings"
        }
    }

    var getProductPriceLabel: String {
        if let price = self.price {
            return String(format: "%.2f TL", price)
        } else {
            return "No price"
        }
    }

    var getProductCategory: String {
        return self.category ?? "UNCATEGORIZED"
    }

    var getProductDescription: String {
        return self.description ?? "No description"
    }

    @MainActor func loadProductImage(into imageView: UIImageView) {
        guard let imageUrl = image, let url = URL(string: imageUrl) else {
            imageView.image = productImage
            return
        }
        imageView.kf.setImage(with: url, placeholder: productImage)
    }

    private var productImage: UIImage {
        return UIImage(named: "placeholder") ?? UIImage()
    }
}
