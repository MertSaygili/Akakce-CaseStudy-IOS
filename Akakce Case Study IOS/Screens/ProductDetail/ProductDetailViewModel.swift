//
//  ProductDetailViewModel.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//


import Foundation

// This protocol is used to get the product detail. Makes communication between the view model and the view controller.
protocol ProductDetailViewModelProtocol {
    var product: ProductModel? { get }
    var errorMessage: String? { get }
    var reloadData: (() -> Void)? { get set }

    func fetchProductDetail()
}


class ProductDetailViewModel: ProductDetailViewModelProtocol {
    private let productId: Int
    private let productService: ProductServiceProtocol

    var product: ProductModel?
    var errorMessage: String?
    var reloadData: (() -> Void)?
    
    init(productId: Int, productService: ProductServiceProtocol) {
        self.productId = productId
        self.productService = productService
    }

    // This function fetches the product detail
    func fetchProductDetail() {
        productService.getProductDetail(id: self.productId) { [weak self] result in
            switch result {
            case .success(let product):
                self?.product = product
                DispatchQueue.main.async {
                    self?.reloadData?()
                }
            case .failure(let error):
                self?.errorMessage = error.message
            }
        }
    }

}
