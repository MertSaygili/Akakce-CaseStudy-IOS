//
//  ProductServiceRoutes.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 5.02.2025.
//

import Foundation

enum ProductServiceRoutes {
    case products(limit: Int)
    case product(id: Int)
}

extension ProductServiceRoutes: URLRequestConvertible {
    // returns the request for the service
    func makeRequest() throws -> URLRequest {
        var baseRequest: URLComponents = try makeServiceRequest(path: path)
        let queryItems: [URLQueryItem]? = queryItems ?? []
        if queryItems != nil {
            baseRequest.queryItems = queryItems
        }


        if baseRequest.url == nil {
            throw NetworkError.invalidUrl
        }

        var request: URLRequest = URLRequest(url: baseRequest.url!)

        request.httpMethod = method

        return request
    }

    // returns the path for the service
    private var path: String {
        switch self {
        case .products:
            return "products"
        case .product(let id):
            return "products/\(id)"
        }
    }

    // returns the method for the service
    private var method: String {
        switch self {
        case .products, .product:
            return NetworkMethods.GET.rawValue
        }
    }

    // returns the query items for the service
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .products(let limit):
            return [URLQueryItem(name: "limit", value: String(limit))]
        default:
            return []
        }
    }

}
