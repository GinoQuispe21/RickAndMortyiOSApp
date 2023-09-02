//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 2/09/23.
//

import Foundation

struct RMGetAllCharactersResponse: Decodable {
    
    struct Info: Decodable {
        
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
        
    }
    
    let info: Info
    let results: [RMCharacter]
    
}
