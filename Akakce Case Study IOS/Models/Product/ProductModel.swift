//
//  NetworkError.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 5.02.2025.
//

// Model of the product model, which is used in the application.
struct ProductModel: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

// Model of the rating model, which is used in the application.
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}

// Enum of the category model, which is used in the application.
// This enums can be different and should be added localization if this are change from the backend. IDK
enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}
