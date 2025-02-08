//
//  ProductsViewControllerProtocol.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit

protocol ProductsViewControllerProtocol: AnyObject {
    func getVerticalProducts() -> [ProductModel]
    func getHorizontalProducts() -> [ProductModel]
    func didSelectVerticalProduct(id: Int?)
    func didSelectHorizontalProduct(id: Int?)
    func refresh()
}

class ProductsViewController: UIViewController, ProductsViewControllerProtocol, ProductsNavigationProtocol {

    // MARK: Properties
    private var viewModel: ProductsViewModelProtocol
    private lazy var productsView = ProductsView()
    private let screenTitle: String = "Products"

    // MARK: Initialization
    init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        self.viewModel.navigationProtocol = self
    }

    required init?(coder: NSCoder) {
        self.viewModel = ProductsViewModel(productService: ProductService())
        super.init(coder: coder)
    }

    // MARK: View Life Cycle
    override func loadView() {
        view = productsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        fetchProducts()
    }

    // MARK: ProductsNavigationProtocol
    func navigateToProductDetail(with viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: ProductsViewControllerProtocol
    func getVerticalProducts() -> [ProductModel] {
        return viewModel.verticalProducts
    }

    func getHorizontalProducts() -> [ProductModel] {
        return viewModel.horizontalProducts
    }

    func didSelectVerticalProduct(id: Int?) {
        if(id == nil) {
            return
        }
        viewModel.didSelectVerticalProduct(id: id!)
    }

    func didSelectHorizontalProduct(id: Int?) {
        if(id == nil) {
            return
        }
        viewModel.didSelectHorizontalProduct(id: id!)
    }

    func refresh() {
        viewModel.refresh()
    }

    // MARK: Setup
    private func setupView() {
        title = screenTitle
        productsView.delegate = self
    }

    private func setupBindings() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.productsView.stopLoading()
                self?.productsView.reloadData()
            }
        }
    }

    private func fetchProducts() {
        productsView.startLoading()
        viewModel.fetchVerticalProducts()
        viewModel.fetchHorizontalProducts()
    }
}
