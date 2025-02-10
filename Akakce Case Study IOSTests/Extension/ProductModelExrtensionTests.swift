//
//  ProductModelExrtensionTests.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 10.02.2025.
//

import XCTest
@testable import Akakce_Case_Study_IOS

class ProductModelExtensionTests: XCTestCase {
    func testGetProductRatingLabel() {
        let product = ProductModel(
            id: 1,
            title: "Test",
            price: 10.0,
            description: "Test",
            category: "Test",
            image: "Test",
            rating: Rating(rate: 4.5, count: 10)
        )

        let ratingLabel = product.getProductRatingLabel

        XCTAssertEqual(ratingLabel, "4.5/5.0")
    }

    func testGetProductPriceLabel() {

        let product = ProductModel(
            id: 1,
            title: "Test",
            price: 10.0,
            description: "Test",
            category: "Test",
            image: "Test",
            rating: Rating(rate: 4.5, count: 10)
        )


        let priceLabel = product.getProductPriceLabel


        XCTAssertEqual(priceLabel, "10.00 $")
    }
}
