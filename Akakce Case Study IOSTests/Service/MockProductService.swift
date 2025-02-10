import XCTest
@testable import Akakce_Case_Study_IOS

class MockProductService: ProductServiceProtocol {

    var mockProducts: [ProductModel] = []
    var mockProduct: ProductModel?
    var shouldFail: Bool = false

    func getProducts(limit: Int, comletion: @escaping (Result<[ProductModel], NetworkError>) -> Void) {
        if shouldFail {
            comletion(.failure(.error))
        } else {
            comletion(.success(mockProducts))
        }
    }

    func getProductDetail(id: Int, comletion: @escaping (Result<ProductModel, NetworkError>) -> Void) {
        if shouldFail {
            comletion(.failure(.error))
        } else if let product = mockProduct {
            comletion(.success(product))
        } else {
            comletion(.failure(.noData))
        }
    }
}
S
