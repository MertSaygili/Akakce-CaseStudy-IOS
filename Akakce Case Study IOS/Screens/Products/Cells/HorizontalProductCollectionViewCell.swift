//
//  HorizontalProductCollectionViewCell.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit
import Kingfisher

final class HorizontalProductCollectionViewCell: UICollectionViewCell {
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 4
        return label
    }()

    private let productStarRatingView: StarRatingView = {
        let view = StarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 4
        return label
    }()

    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        layer.cornerRadius = 12
        clipsToBounds = true

        // Add subviews
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productStarRatingView)
        addSubview(productDescriptionLabel)
        addSubview(productPriceLabel)

        // Constraints
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            productImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),

            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),

            productStarRatingView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            productStarRatingView.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            productStarRatingView.heightAnchor.constraint(equalToConstant: 20),
            productStarRatingView.widthAnchor.constraint(equalToConstant: 100),

            productDescriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productDescriptionLabel.topAnchor.constraint(equalTo: productStarRatingView.bottomAnchor, constant: 4),


            productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            productPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productPriceLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 4)

            ])
    }

    func configure(with product: ProductModel) {
        product.loadProductImage(into: productImageView)
        productStarRatingView.setRating(product.rating?.rate ?? 0)
        productNameLabel.text = product.title
        productPriceLabel.text = product.getProductPriceLabel
        productDescriptionLabel.text = product.getProductDescription
    }
}
