//
//  NetworkError.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 5.02.2025.
//

import Foundation

// Network Error Handling, This enum is used in the NetworkManager class.
// This class should be improved, the error messages should be more detailed. And make it localized.
// Might be the next case is sending Toast or Alert to the user. After getting the error.
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
