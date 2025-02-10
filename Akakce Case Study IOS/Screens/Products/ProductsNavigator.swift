//
//  ProductsNavigator.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit

// This protocol for the navigation between the products to product detail.
protocol ProductsNavigationProtocol: AnyObject {
    func navigateToProductDetail(with viewController: UIViewController)
}
