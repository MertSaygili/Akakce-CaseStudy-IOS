import UIKit

final class ProductsView: UIView {
    // MARK: - UI Components
    private lazy var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HorizontalProductCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private lazy var gridCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GridProductCollectionViewCell.self, forCellWithReuseIdentifier: GridProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: - Properties
    weak var delegate: ProductsViewControllerProtocol?
    private var horizontalProducts: [ProductModel] = []
    private var verticalProducts: [ProductModel] = []

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ProductsViewProtocol
extension ProductsView {
    func setupUI() {
        backgroundColor = .systemBackground

        addSubview(horizontalCollectionView)
        addSubview(gridCollectionView)
        addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            horizontalCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalCollectionView.heightAnchor.constraint(equalToConstant: 200),

            gridCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 16),
            gridCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            gridCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            gridCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }

    func reloadData() {
        if let horizontalProducts = delegate?.getHorizontalProducts(),
            let verticalProducts = delegate?.getVerticalProducts() {
            self.horizontalProducts = horizontalProducts
            self.verticalProducts = verticalProducts
            horizontalCollectionView.reloadData()
            gridCollectionView.reloadData()
        }
    }

    func startLoading() {
        loadingIndicator.startAnimating()
    }

    func stopLoading() {
        loadingIndicator.stopAnimating()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ProductsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView {
            return horizontalProducts.count
        } else {
            return verticalProducts.count
        }
    }

    // Cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == horizontalCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalProductCollectionViewCell.identifier, for: indexPath) as? HorizontalProductCollectionViewCell else {
                return UICollectionViewCell()
            }
            let product = horizontalProducts[indexPath.row]
            cell.configure(with: product)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridProductCollectionViewCell.identifier, for: indexPath) as? GridProductCollectionViewCell else {
                return UICollectionViewCell()
            }
            let product = verticalProducts[indexPath.row]
            cell.configure(with: product)
            return cell
        }
    }

    // Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCollectionView {
            return CGSize(width: collectionView.frame.width, height: 200) // Full width for horizontal collection view
        } else {
            let padding: CGFloat = 8
            let availableWidth = collectionView.frame.width - padding
            let itemWidth = availableWidth / 2
            return CGSize(width: itemWidth, height: itemWidth * 1.5) // 2 items per row
        }
    }

    // Handle selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == horizontalCollectionView {
            delegate?.didSelectHorizontalProduct(at: indexPath.row)
        } else {
            delegate?.didSelectVerticalProduct(at: indexPath.row)
        }
    }
}
