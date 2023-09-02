//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 27/08/23.
//

import Foundation

/// Object that represents a single API call
final class RMRequest {
    
    /// Desired endpoint
    public let endpoint: RMEndpoint
    /// Path components for API, if any
    public let pathComponents: [String]
    /// Query arguments for API, if any
    public let queryParameters: [URLQueryItem]
    public let httpMethod = "GET"
    
    /// Computed property that construct url for the API request in string format
    private var urlString: String {
        var string = RMConstants.baseURL + "/" + endpoint.rawValue
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        if !queryParameters.isEmpty {
            string += "/"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        return string
    }
    
    /// Computed property API url
    public var url: URL? { return URL(string: urlString) }
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of Query Parameters
    public init(
        endpoint: RMEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
}

extension RMRequest {
    
    static let listCharactersRequest = RMRequest(endpoint: .character)
    
}
