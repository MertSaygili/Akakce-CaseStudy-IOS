//
//  StarRatingView.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit

final class StarRatingView: UIView {
    // MARK: - Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    // MARK: - Public Methods
    func setRating(_ rating: Double) {
        // Clear existing stars
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // Add stars based on the rating
        let fullStars = Int(rating)
        let hasHalfStar = rating - Double(fullStars) >= 0.5

        // Add full stars
        for _ in 0..<fullStars {
            let starImageView = UIImageView(image: UIImage().fillStarImage)
            starImageView.tintColor = .systemYellow
            stackView.addArrangedSubview(starImageView)
        }

        // Add half star if needed
        if hasHalfStar {
            let halfStarImageView = UIImageView(image: UIImage().halfStarImage)
            halfStarImageView.tintColor = .systemYellow
            stackView.addArrangedSubview(halfStarImageView)
        }

        // Add empty stars for the remaining
        let remainingStars = 5 - fullStars - (hasHalfStar ? 1 : 0)
        for _ in 0..<remainingStars {
            let starImageView = UIImageView(image: UIImage().emptyStarImage)
            starImageView.tintColor = .systemYellow
            stackView.addArrangedSubview(starImageView)
        }
    }
}
