//
//  ProductsViewModelProtocol.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import Foundation
import UIKit

// This protocol is for the communication between view model and view controller.
protocol ProductsViewModelProtocol {
    var horizontalProducts: [ProductModel] { get }
    var verticalProducts: [ProductModel] { get }
    var errorMessage: String? { get set }
    var reloadData: (() -> Void)? { get set }
    var navigationProtocol: ProductsNavigationProtocol? { get set }


    func fetchHorizontalProducts()
    func fetchVerticalProducts()
    func didSelectVerticalProduct(id: Int)
    func didSelectHorizontalProduct(id: Int)
    func refresh()
}


class ProductsViewModel: ProductsViewModelProtocol {
    private let productService: ProductServiceProtocol
    var horizontalProducts: [ProductModel] = []
    var verticalProducts: [ProductModel] = []
    var errorMessage: String?
    var reloadData: (() -> Void)?
    weak var navigationProtocol: ProductsNavigationProtocol?


    init(productService: ProductServiceProtocol) {
        self.productService = productService
    }

    // There is naming, issue, might me the popular products etc.
    func fetchHorizontalProducts() {
        productService.getProducts(limit: 5) { [weak self] result in
            switch result {
            case .success(let products):
                self?.horizontalProducts = products
                DispatchQueue.main.async {
                    self?.reloadData?()
                }
            case .failure(let error):
                self?.errorMessage = error.message
            }
        }
    }

    // There is naming, issue, might me the daily products etc.
    func fetchVerticalProducts() {
        productService.getProducts(limit: 20) { [weak self] result in
            switch result {
            case .success(let products):
                self?.verticalProducts = products
                DispatchQueue.main.async {
                    self?.reloadData?()
                }
            case .failure(let error):
                self?.errorMessage = error.message
            }
        }
    }

    func refresh() {
        fetchHorizontalProducts()
        fetchVerticalProducts()
    }

    func didSelectVerticalProduct(id: Int) {
        guard verticalProducts.first(where: { $0.id == id }) != nil else { return }
        pushToProductDetailPage(productId: id)
    }

    func didSelectHorizontalProduct(id: Int) {
        guard horizontalProducts.first(where: { $0.id == id }) != nil else { return }
        pushToProductDetailPage(productId: id)
    }

    private func pushToProductDetailPage(productId: Int) {
        let productDetailViewModel = ProductDetailViewModel(productId: productId, productService: productService)
        let productDetailViewController = ProductDetailViewController(viewModel: productDetailViewModel)

        // Push to product detail page
        navigationProtocol?.navigateToProductDetail(with: productDetailViewController)
    }
}
