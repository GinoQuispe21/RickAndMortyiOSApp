//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 2/09/23.
//

import UIKit

/// View that handles showing list of characters, loaders, etc
final class RMCharacterListView: UIView {

    private let viewModel = RMCharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        // layour for margin
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0 //opacity
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        // Register cell
        collectionView.register(
            RMCharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        // Init spinner
        addSubViews(
            collectionView,
            spinner
        )
        addContraints()
        spinner.startAnimating()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            // Spinner constraints
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            // CollectionView contraints
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    private func setupCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 2,
            execute: {
                self.spinner.stopAnimating()
                self.collectionView.isHidden = false
                UIView.animate(withDuration: 0.4, animations: {
                    self.collectionView.alpha = 1
                })
            })
    }

}
