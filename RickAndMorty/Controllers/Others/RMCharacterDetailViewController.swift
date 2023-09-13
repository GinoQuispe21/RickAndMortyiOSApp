//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 4/09/23.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {

    private let viewModel: RMCharacterDetailViewViewModel
    
    private let detailView: RMCharacterDetailView?
    
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(
            nibName: nil, bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare))
        view.addSubview(detailView)
        addContraints()
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
    }
    
    @objc
    private func didTapShare() {
        // Share character info
    }
    
}

extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemPink
        return cell
    }
    
    
}
