//
//  NetworkConstants.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

// This class is used to keep the network constants.
// Private, Singleton, Immutable class
final class NetworkConstants {
    private init() { }

    static let shared: NetworkConstants = NetworkConstants()

    // In best case this variables readed from the .env file, or .config file etc.
    final let baseUrlScheme = "https"
    final let baseUrl = "fakestoreapi.com"
}
