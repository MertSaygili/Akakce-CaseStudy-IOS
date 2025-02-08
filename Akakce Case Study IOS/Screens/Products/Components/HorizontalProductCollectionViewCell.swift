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
        label.textAlignment = .center
        label.numberOfLines = 2
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
        backgroundColor = .systemGray5
        layer.cornerRadius = 8
        clipsToBounds = true

        addSubview(productImageView)
        addSubview(productNameLabel)

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),

            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            productNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
    }

    func configure(with product: ProductModel) {
        product.loadProductImage(into: productImageView)
        productNameLabel.text = product.title
    }
}
