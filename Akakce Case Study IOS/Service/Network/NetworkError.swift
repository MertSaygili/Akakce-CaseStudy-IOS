//
//  NetworkError.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 5.02.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case requestFailed(statusCode: Int)
    case invalidResponse
    case dataConversionFailure
    case error
    case noData
    case decodingError(decodingError: Error)

    var message: String {
        switch self {
        case .invalidUrl:
            return "Invalid Url"
        case .requestFailed(let statusCode):
            return "Request Failed \(statusCode)"
        case .invalidResponse:
            return "Invalid Response"
        case .dataConversionFailure:
            return "Data Conversion Failure"
        case .error:
            return "Unknown Error"
        case .noData:
            return "No Data, Decoding Error" case .decodingError:
            return "Decoding Error"
        }
    }
}
