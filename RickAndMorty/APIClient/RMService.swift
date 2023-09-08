//
//  RMService.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 27/08/23.
//

import Foundation

/// Primary API service object to get Rick And Morty Data
final class RMService {
    
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Privatized constructir
    private init() {}
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expected to get back
    ///   - completion: Callback with data or error
    public func execute<T: Decodable>(
        _ request: RMRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        print("API CALL", request.url)
        guard let urlRequest = requestMethod(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func requestMethod(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
