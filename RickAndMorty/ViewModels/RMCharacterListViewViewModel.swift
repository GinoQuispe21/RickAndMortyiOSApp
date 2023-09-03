//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 2/09/23.
//

import Foundation
import UIKit

final class RMCharacterListViewViewModel: NSObject {
    
    func fetchAllCharacters() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let response):
                dump(response)
                print("Total", String(response.info.count))
                print("Page result count: ", String(response.results.count))
                break
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = RMCharacterCollectionViewCellViewModel(
            characterName: "Gino",
            characterStatus: .alive,
            characterImageUrl: nil
        )
        cell.configure(with: viewModel)
        cell.backgroundColor = .systemGreen
        return cell
    }
    
}

extension RMCharacterListViewViewModel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
}
