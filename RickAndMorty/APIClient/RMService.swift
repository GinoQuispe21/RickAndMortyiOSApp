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
    public let shared = RMService()
    
    /// Privatized constructir
    private init() {}
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
         
    }
    
}
