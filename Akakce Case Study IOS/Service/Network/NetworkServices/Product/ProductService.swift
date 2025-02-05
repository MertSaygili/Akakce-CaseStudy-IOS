//
//  Untitled.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 5.02.2025.
//

protocol ProductServiceProtocol {
    func getProducts(comletion: @escaping (Result<[ProductModel], NetworkError>) -> Void)
    func getProductDetail(id: Int, comletion: @escaping (Result<ProductModel, NetworkError>) -> Void) -> ProductModel
}
