//
//  RMEpisode.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 23/08/23.
//

import Foundation

struct RMEpisode : Decodable {
    
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    
}
