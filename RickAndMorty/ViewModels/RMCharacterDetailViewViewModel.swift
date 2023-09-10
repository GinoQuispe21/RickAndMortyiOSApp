//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 4/09/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private var character: RMCharacter
    
    public var requestUrl: URL? {
        return  URL(string: character.url)
    }
    
    init(character: RMCharacter){
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    // Redundant code that not needed because is the same response that get all characters fetch
    public func fetchCharacterInfo() {
        print(character.url)
        guard let url = requestUrl, let request = RMRequest(url: url) else {
            print("Failed to create")
            return
        }
        RMService.shared.execute(
            request,
            expecting: RMCharacter.self,
            completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }
        )
    }
    
}
