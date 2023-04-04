//
//  MainViewController.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import RxSwift
import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    var mainCoordinatorDelegate: MainCoordinatorDelegate?
    var viewModel = MainViewModel()
    var movieListCollectionView: UICollectionView!
    
    //MARK: - Subscriptions
    let disposeBag = DisposeBag()
    
    //MARK: - View Launch
    override func viewWillAppear(_ animated: Bool) {
        self.movieListCollectionView.reloadSections(IndexSet(integersIn: 1...2))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "flix."
        
        self.view.backgroundColor = .white
        
        self.addCollectionView()
        self.prepareCollectionView()
        self.prepareMovieChangeSubscription()
        
        viewModel.getMovies()
    }
    
    //MARK: - Prepare Collection View and Data Source Subscriptions
    func prepareCollectionView() {
        self.movieListCollectionView.dataSource = self
        self.movieListCollectionView.delegate = self
        
        self.movieListCollectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        self.movieListCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        self.movieListCollectionView.register(FooterCell.self, forCellWithReuseIdentifier: FooterCell.identifier)
    }
    
    func prepareMovieChangeSubscription() {
        viewModel.movieDataSourceObserver.subscribe(
            onNext: { [weak self] in
                UIView.performWithoutAnimation {
                    guard let self = self else { return }
                    self.movieListCollectionView.reloadSections(IndexSet(integersIn: 1...2))
                }
            }, onError: { [weak self] _ in
                guard let self = self else { return }
                self.movieListCollectionView.reloadSections(IndexSet(integer: 2))
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Navigation
    func moveToDetailsScreen(movieDetails: MovieDetails) {
        self.view.endEditing(true)
        mainCoordinatorDelegate?.moveToDetailsView(movieDetails: movieDetails)
    }
}
