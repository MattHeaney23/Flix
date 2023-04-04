//
//  MainViewController+CollectionViewDelegates.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import UIKit

///Extension for the UICollectionViewDataSource for the MainViewController
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return self.viewModel.movies.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
                return UICollectionViewCell()
            }
            
            let cellViewModel = SearchCellViewModel(startingTerm: viewModel.entererSearchTerm)
            cell.setUp(searchCellViewModel: cellViewModel, searchBarDelegate: self)
            return cell
        }
        
        else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }
            
            let cellViewModel = MovieCellViewModel(movie: self.viewModel.movies[indexPath.item])
            cell.setUp(viewModel: cellViewModel)
            return cell
        }
        
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FooterCell.identifier, for: indexPath) as? FooterCell else {
                return UICollectionViewCell()
            }
            
            let cellViewModel = FooterCellViewModel(state: viewModel.state)
            cell.setup(viewModel: cellViewModel)
            viewModel.loadMoreResults()
            return cell
        }
    }
}

///Extension for the UICollectionViewDelegate for the MainViewController
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
        self.moveToDetailsScreen(movieDetails: viewModel.movies[indexPath.row])
    }
}

///Extension for the UICollectionViewDelegateFlowLayout for the MainViewController
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return self.viewModel.calculateCellSize(collectionViewWidth: self.movieListCollectionView.frame.width)
        } else {
            return CGSize(width: self.movieListCollectionView.frame.width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
