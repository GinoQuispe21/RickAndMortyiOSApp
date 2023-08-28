//
//  RMEndpoints.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 27/08/23.
//

import Foundation

/// Represents unique API endpoints
@frozen enum RMEndpoint: String {
    
    /// Endpoint to get character info
    case character // "character"
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
    
}
