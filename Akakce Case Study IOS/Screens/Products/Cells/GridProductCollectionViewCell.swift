//
//  GridProductCollectionViewCell.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit
import Kingfisher

final class GridProductCollectionViewCell: UICollectionViewCell {
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()

    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemBlue
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupUI() {
        backgroundColor = .clear
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor

        addSubview(productImageView)
        addSubview(productNameLabel)

        addSubview(productPriceLabel)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),

            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 0),
            productPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)

            ])
    }

    func configure(with product: ProductModel) {
        product.loadProductImage(into: productImageView)
        productNameLabel.text = product.title
        productPriceLabel.text = product.getProductPriceLabel
    }
}
