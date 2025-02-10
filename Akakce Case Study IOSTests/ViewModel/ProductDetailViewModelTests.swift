//
//  ProductDetailViewModelTests.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 10.02.2025.
//

import XCTest
@testable import Akakce_Case_Study_IOS

class ProductDetailViewModelTests: XCTestCase {
    var sut: ProductDetailViewModel!
    var mockService: MockProductService!

    override func setUp() {
        super.setUp()
        mockService = MockProductService()
        sut = ProductDetailViewModel(productId: 1, productService: mockService)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchProductDetail_Success() {
        let expectation = expectation(description: "Fetch product detail")
        let mockProduct = ProductModel(id: 1, title: "Test", price: 10.0, description: "Test", category: "Test", image: "Test", rating: Rating(rate: 4.5, count: 10))
        mockService.mockProduct = mockProduct

        sut.reloadData = {
            expectation.fulfill()
        }

        sut.fetchProductDetail()

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.sut.product?.id, 1)
            XCTAssertEqual(self.sut.product?.title, "Test")
        }
    }

    func testFetchProductDetail_Failure() {
        let expectation = expectation(description: "Fetch product detail failure")
        mockService.shouldFail = true

        sut.fetchProductDetail()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(self.sut.errorMessage)
            XCTAssertNil(self.sut.product)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
