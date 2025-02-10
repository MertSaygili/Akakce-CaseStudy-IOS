//
//  ProductDetailViewController.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit

// This protocol is used to get the product detail. and makes communication with the product detail view.
protocol ProductDetailsViewControllerProtocol: AnyObject {
    func getProductDetail() -> ProductModel?
}

class ProductDetailViewController: UIViewController, ProductDetailsViewControllerProtocol {

    // MARK: Properties
    private var viewModel: ProductDetailViewModelProtocol;
    private lazy var productDetailView = ProductDetailView()
    private let screenTitle = "Product Detail"

    // MARK: Initialization
    init(viewModel: ProductDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = ProductDetailViewModel(productId: 0, productService: ProductService())
        super.init(coder: coder)
    }

    // MARK: View Life Cycle
    override func loadView() {
        view = productDetailView
    }

    override func viewDidLoad() {
        setupView()
        setupBindings()
        fetchProductDetail()
        super.viewDidLoad()
    }

    // MARK: ProductDetailsViewControllerProtocol
    func getProductDetail() -> ProductModel? {
        return viewModel.product
    }

    // MARK: Setup
    private func setupView() {
        title = screenTitle
        productDetailView.delegate = self
    }

    private func setupBindings() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.productDetailView.stopLoading()
                self?.productDetailView.reloadData()
            }
        }
    }

    private func fetchProductDetail() {
        productDetailView.startLoading()
        viewModel.fetchProductDetail()
    }
}
