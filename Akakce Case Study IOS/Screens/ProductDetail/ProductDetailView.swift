import UIKit
import Kingfisher

final class ProductDetailView: UIView {

    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 16
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        imageView.layer.shadowOpacity = 0.1
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private let priceContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        return view
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        label.textColor = .systemBlue
        label.textAlignment = .center
        return label
    }()

    private let categoryContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        return view
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        return label
    }()

    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        return label
    }()

    private let ratingContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()

    private let ratingView: StarRatingView = {
        let view = StarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: - Properties
    weak var delegate: ProductDetailsViewControllerProtocol?
    private var product: ProductModel?

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Configure View
    func configure(with product: ProductModel) {
        product.loadProductImage(into: productImageView)
        titleLabel.text = product.title
        priceLabel.text = product.getProductPriceLabel
        descriptionLabel.text = product.getProductDescription
        categoryLabel.text = product.getProductCategory
        ratingView.setRating(product.rating?.rate ?? 0)
        ratingLabel.text = product.getProductRatingLabel
    }

    // MARK: - Setup UI
    private func setupUI() {
        backgroundColor = .systemBackground

        // Add scroll view and content view
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Add subviews to content view
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)

        contentView.addSubview(priceContainer)
        priceContainer.addSubview(priceLabel)

        contentView.addSubview(categoryContainer)
        categoryContainer.addSubview(categoryLabel)

        contentView.addSubview(ratingContainer)
        ratingContainer.addSubview(ratingView)
        ratingContainer.addSubview(ratingLabel)

        contentView.addSubview(descriptionTitleLabel)
        contentView.addSubview(descriptionLabel)

        addSubview(loadingIndicator)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll view
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Content view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Product image
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor, multiplier: 0.8),

            // Title
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Price container
            priceContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            priceContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceContainer.heightAnchor.constraint(equalToConstant: 60),

            // Price label
            priceLabel.centerYAnchor.constraint(equalTo: priceContainer.centerYAnchor),
            priceLabel.centerXAnchor.constraint(equalTo: priceContainer.centerXAnchor),

            // Category container
            categoryContainer.topAnchor.constraint(equalTo: priceContainer.bottomAnchor, constant: 16),
            categoryContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryContainer.heightAnchor.constraint(equalToConstant: 32),

            // Category label
            categoryLabel.leadingAnchor.constraint(equalTo: categoryContainer.leadingAnchor, constant: 12),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryContainer.trailingAnchor, constant: -12),
            categoryLabel.centerYAnchor.constraint(equalTo: categoryContainer.centerYAnchor),

            // Rating container
            ratingContainer.topAnchor.constraint(equalTo: priceContainer.bottomAnchor, constant: 16),
            ratingContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ratingContainer.heightAnchor.constraint(equalToConstant: 32),
            ratingContainer.leadingAnchor.constraint(equalTo: categoryContainer.trailingAnchor, constant: 8),
            ratingContainer.widthAnchor.constraint(equalTo: categoryContainer.widthAnchor),

            // Rating view
            ratingView.centerYAnchor.constraint(equalTo: ratingContainer.centerYAnchor),
            ratingView.centerXAnchor.constraint(equalTo: ratingContainer.centerXAnchor),
            ratingView.heightAnchor.constraint(equalToConstant: 20),
            ratingView.widthAnchor.constraint(equalToConstant: 100),

            // Rating label
            ratingLabel.topAnchor.constraint(equalTo: ratingContainer.bottomAnchor, constant: 4),
            ratingLabel.centerXAnchor.constraint(equalTo: ratingContainer.centerXAnchor),

            // Description title
            descriptionTitleLabel.topAnchor.constraint(equalTo: categoryContainer.bottomAnchor, constant: 24),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Description
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            // Loading indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }

    func reloadData() {
        guard let product = delegate?.getProductDetail() else { return }
        configure(with: product)
    }

    func startLoading() {
        loadingIndicator.startAnimating()
    }

    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
}
