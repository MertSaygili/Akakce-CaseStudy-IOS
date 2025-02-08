//
//  Untitled.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 5.02.2025.
//

protocol ProductServiceProtocol {
    func getProducts(limit: Int, comletion: @escaping (Result<[ProductModel], NetworkError>) -> Void)
    func getProductDetail(id: Int, comletion: @escaping (Result<ProductModel, NetworkError>) -> Void) -> ProductModel
}


class ProductService: ProductServiceProtocol {
    func getProducts(limit: Int = 20, comletion: @escaping (Result<[ProductModel], NetworkError>) -> Void) {
        do {
            let request = try ProductServiceRoutes.products(limit: limit).makeRequest()
            NetworkManager.shared.request(request: request, completion: comletion)
        } catch {
            comletion(.failure(.invalidUrl))
        }
    }

    func getProductDetail(id: Int, comletion: @escaping (Result<ProductModel, NetworkError>) -> Void) -> ProductModel {
        // Implementation for product detail - not needed for this task
        return ProductModel(
            id: 0,
            title: "",
            price: 0,
            description: "",
            category: "",
            image: "",
            rating: nil
        )
    }
}
