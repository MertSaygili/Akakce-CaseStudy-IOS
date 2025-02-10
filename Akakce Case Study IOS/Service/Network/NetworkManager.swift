//
//  NetworkManager.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 5.02.2025.
//

import Foundation

class NetworkManager {

    // Singleton instance
    static let shared: NetworkManager = NetworkManager()

    private init() { }

    // This function is used to make a network request.
    func request<T: Codable>(
        request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.error))
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError: decodingError)))
            }
        }
        task.resume()
    }
}
