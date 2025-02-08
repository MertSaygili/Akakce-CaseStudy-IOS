//
//  NetworkServiceRoutes.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 5.02.2025.
//

import Foundation

protocol URLRequestConvertible {
    func makeRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    func makeServiceRequest(path: String) throws -> URLComponents {
        var urlComponent: URLComponents? = URLComponents()

        urlComponent?.scheme = NetworkConstants.shared.baseUrlScheme
        urlComponent?.host = NetworkConstants.shared.baseUrl
        urlComponent?.path = "/" + path

        if urlComponent == nil {
            throw NetworkError.invalidUrl
        }

        return urlComponent!
    }
}
