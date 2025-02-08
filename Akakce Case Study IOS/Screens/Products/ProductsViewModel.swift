import Foundation

protocol ProductsViewModelProtocol {
    var horizontalProducts: [ProductModel] { get }
    var verticalProducts: [ProductModel] { get }
    var errorMessage: String? { get set }
    var reloadData: (() -> Void)? { get set }

    func fetchHorizontalProducts()
    func fetchVerticalProducts()
}

class ProductsViewModel: ProductsViewModelProtocol {
    private let productService: ProductServiceProtocol
    var horizontalProducts: [ProductModel] = []
    var verticalProducts: [ProductModel] = []
    var errorMessage: String?
    var reloadData: (() -> Void)?

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
}
