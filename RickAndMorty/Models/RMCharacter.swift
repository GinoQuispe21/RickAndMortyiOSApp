//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 23/08/23.
//

import Foundation

struct RMCharacter: Decodable {
    
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMOrigin
    let location: RMCharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
     
}

enum RMCharacterStatus: String, Decodable {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead: return rawValue
        case .unknown: return "Unknown"
        }
    }
    
}

enum RMCharacterGender: String, Decodable {
    
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
    
}

struct RMOrigin: Decodable {
    
    let name: String
    let url: String
    
}

struct RMCharacterLocation: Decodable {
    
    let name: String
    let url: String
    
}
