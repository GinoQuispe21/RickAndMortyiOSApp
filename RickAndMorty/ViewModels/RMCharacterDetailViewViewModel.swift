//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 4/09/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private var character: RMCharacter
    
    init(character: RMCharacter){
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
}
