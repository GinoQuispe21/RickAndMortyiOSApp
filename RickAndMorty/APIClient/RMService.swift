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
         
    }
    
}
