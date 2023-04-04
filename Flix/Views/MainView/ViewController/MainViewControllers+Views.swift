//
//  MainViewControllers+Views.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import UIKit

///Extension for the UIViews for the MainViewController
extension MainViewController {
    func addCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -16),
            collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.movieListCollectionView = collectionView
    }
}
