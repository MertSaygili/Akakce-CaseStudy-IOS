//
//  ProductsView.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit

final class ProductsView: UIView {

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

    private lazy var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            HorizontalProductCollectionViewCell.self,
            forCellWithReuseIdentifier: HorizontalProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.hidesForSinglePage = true
        return pageControl
    }()

    private lazy var gridCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            GridProductCollectionViewCell.self,
            forCellWithReuseIdentifier: GridProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemBlue
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Properties
    weak var delegate: ProductsViewControllerProtocol?
    private var horizontalProducts: [ProductModel] = []
    private var verticalProducts: [ProductModel] = []
    private var horizontalCollectionViewHeightConstraint: NSLayoutConstraint?

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupOrientationObserver()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Orientation Handling
    private func setupOrientationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleOrientationChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    @objc private func handleOrientationChange() {
        updateHorizontalCollectionViewLayout()
    }

    private func updateHorizontalCollectionViewLayout() {
        let isLandscape = UIDevice.current.orientation.isLandscape
        let height = isLandscape ? bounds.height * 0.25 : 200
        horizontalCollectionViewHeightConstraint?.constant = height

        if let layout = horizontalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            // Ensure we have a valid width
            let width = scrollView.bounds.width > 0 ? scrollView.bounds.width : bounds.width
            layout.itemSize = CGSize(width: width, height: height)
            layout.invalidateLayout()
        }
        horizontalCollectionView.reloadData()
    }

    // MARK: - Refresh Control
    @objc private func handleRefresh() {
        delegate?.refresh()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}

// MARK: - UI Setup, Data Handling
extension ProductsView {
    func setupUI() {
        backgroundColor = .systemBackground

        // Add subviews
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(horizontalCollectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(gridCollectionView)
        contentView.addSubview(loadingIndicator)

        horizontalCollectionViewHeightConstraint = horizontalCollectionView.heightAnchor.constraint(equalToConstant: 200)
        scrollView.refreshControl = refreshControl

        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Content view constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Horizontal collection view constraints
            horizontalCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalCollectionViewHeightConstraint ?? NSLayoutConstraint(),

            // Page control constraints
            pageControl.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            // Grid collection view constraints
            gridCollectionView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 16),
            gridCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            gridCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            gridCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            // Loading indicator constraints
            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            ])

        updateHorizontalCollectionViewLayout()
    }

    func reloadData() {
        if let horizontalProducts = delegate?.getHorizontalProducts(),
            let verticalProducts = delegate?.getVerticalProducts()
        {
            self.horizontalProducts = horizontalProducts
            self.verticalProducts = verticalProducts
            horizontalCollectionView.reloadData()
            gridCollectionView.reloadData()

            updateGridCollectionViewLayout()

            pageControl.numberOfPages = horizontalProducts.count
            pageControl.currentPage = 0
        }
    }

    func startLoading() {
        loadingIndicator.startAnimating()
    }

    func stopLoading() {
        loadingIndicator.stopAnimating()
    }

    private func updateGridCollectionViewLayout() {
        let padding: CGFloat = 8
        let availableWidth = gridCollectionView.frame.width - padding
        let itemWidth = availableWidth / 2
        let itemHeight = itemWidth * 1.5

        let itemsPerRow = 2
        let numberOfRows = ceil(Double(verticalProducts.count) / Double(itemsPerRow))

        let totalHeight = (itemHeight * CGFloat(numberOfRows)) + (padding * (CGFloat(numberOfRows) - 1))

        gridCollectionView.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true

        contentView.layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ProductsView: UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int
    {
        if collectionView == horizontalCollectionView {
            return horizontalProducts.count
        } else {
            return verticalProducts.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        if collectionView == horizontalCollectionView {
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HorizontalProductCollectionViewCell.identifier,
                for: indexPath) as? HorizontalProductCollectionViewCell
                else {
                return UICollectionViewCell()
            }
            let product = horizontalProducts[indexPath.row]
            cell.configure(with: product)
            return cell
        } else {
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GridProductCollectionViewCell.identifier, for: indexPath)
            as? GridProductCollectionViewCell
                else {
                return UICollectionViewCell()
            }
            let product = verticalProducts[indexPath.row]
            cell.configure(with: product)
            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == horizontalCollectionView {
            let width = scrollView.bounds.width > 0 ? scrollView.bounds.width : bounds.width
            return CGSize(
                width: width,
                height: horizontalCollectionViewHeightConstraint?.constant ?? 200
            )
        } else {
            let padding: CGFloat = 8
            let availableWidth = collectionView.frame.width - padding
            let itemWidth = availableWidth / 2
            return CGSize(width: itemWidth, height: itemWidth * 1.5)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == horizontalCollectionView {
            let productId = horizontalProducts[indexPath.row]
            delegate?.didSelectHorizontalProduct(id: productId.id)
        } else {
            let productId = verticalProducts[indexPath.row]
            delegate?.didSelectVerticalProduct(id: productId.id)
        }
    }


    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == horizontalCollectionView {
            let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
            pageControl.currentPage = page
        }
    }
}
