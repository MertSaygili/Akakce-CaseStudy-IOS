import UIKit

protocol ProductsViewControllerProtocol: AnyObject {
    func getVerticalProducts() -> [ProductModel]
    func getHorizontalProducts() -> [ProductModel]
    func didSelectVerticalProduct(at index: Int)
    func didSelectHorizontalProduct(at index: Int)

}

class ProductsViewController: UIViewController, ProductsViewControllerProtocol {

    private var viewModel: ProductsViewModelProtocol
    private lazy var productsView = ProductsView()

    // MARK: Initialization
    init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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

    // MARK: ProductsViewControllerProtocol
    func getVerticalProducts() -> [ProductModel] {
        return viewModel.verticalProducts
    }

    func getHorizontalProducts() -> [ProductModel] {
        return viewModel.horizontalProducts
    }

    func didSelectVerticalProduct(at index: Int) {
        print("Vertical product selected at index: \(index)")
    }

    func didSelectHorizontalProduct(at index: Int) {
        print("Horizontal product selected at index: \(index)")
    }

    // MARK: Setup
    private func setupView() {
        title = "Products"
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
