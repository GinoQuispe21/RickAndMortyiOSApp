//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 2/09/23.
//

import Foundation
import UIKit

protocol RMCharacterListViewViewModelDelegate: NSObject {
    
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPath: [IndexPath])
    func didSelectCharacter(_ rmCharacter: RMCharacter)
    
}

/// View Model to handle character list view logic
final class RMCharacterListViewViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isLoadingData: Bool = false
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    public var shouldShowMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    /// Function to fetch initial characters (20)
    public func fetchAllCharacters() {
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharactersResponse.self
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                characters = results
                apiInfo = info
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialCharacters()
                }
                break
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Pagination if additional characters are needed
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingData else { return }
        isLoadingData = true
        guard let request = RMRequest(url: url) else {
            print("Failed to create request")
            return
        }
        RMService.shared.execute(
            request,
            expecting: RMGetAllCharactersResponse.self,
            completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case.success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    apiInfo = info
                    
                    let originalCount = characters.count
                    let newCount = moreResults.count
                    let total = originalCount + newCount
                    let startingIndex = total - newCount - 1
                    let indexPathsAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                        return IndexPath(row: $0, section: 0)
                    })
                    characters.append(contentsOf: moreResults)
                    print(characters.count)
                    DispatchQueue.main.async {
                        self.delegate?.didLoadMoreCharacters(
                            with: indexPathsAdd
                        )
                        self.isLoadingData = false
                    }
                case.failure(let error):
                    print(error)
                    isLoadingData = false
                }
            }
        )
    }
    
}

/// Colection View implementation datasa source
extension RMCharacterListViewViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath
            ) as? RMFooterLoadingCollectionReusableView else {
                fatalError("Unsupported")
            }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowMoreIndicator else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
}

extension RMCharacterListViewViewModel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
}

/// ScrollView
extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowMoreIndicator,
              !isLoadingData,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString)
        else {
            return
        }
        Timer.scheduledTimer(
            withTimeInterval: 0.2,
            repeats: false,
            block: { [weak self] t in
                guard let self = self else { return }
                let offset = scrollView.contentOffset.y
                let totalContentHeight = scrollView.contentSize.height
                let totalScrollViewFixedHeight = scrollView.frame.size.height
                if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                    fetchAdditionalCharacters(url: url)
                }
                t.invalidate()
            }
        )
    }
    
}
