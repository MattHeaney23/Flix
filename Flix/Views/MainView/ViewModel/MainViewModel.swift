//
//  MainViewModel.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import RxSwift
import UIKit

class MainViewModel {
    
    //MARK: - Movie Properties
    var state: MainViewModelState = .ready
    var movies: [MovieDetails] = []
    var currentPageOfMovies = 0
    var entererSearchTerm: String = ""
    
    //MARK: - Collection View Properties
    private let numberOfCollectionViewColumns = 3.0
    private let collectionViewCellPadding = 16.0
    
    //MARK: - Subscriptions
    let movieDataSourceObserver = PublishSubject<()>()
    private var networkRequestDisposable: Disposable?
    private let disposeBag = DisposeBag()
    
    //MARK: - Service Dependancies
    private let networkingService: NetworkServiceProtocol
    
    //MARK: - View Launch
    ///Initialise MainViewModel. networkingService defaults to 'NetworkService.Shared' if no value set. This allows for injecting mocked versions of the service
    init(networkingService: NetworkServiceProtocol = NetworkService.Shared) {
        self.networkingService = networkingService
    }
    
    // MARK: - Load Movies
    func prepareForNewResults() {
        networkRequestDisposable?.dispose()
        self.currentPageOfMovies = 0
        self.movies = []
        self.state = .ready
        self.movieDataSourceObserver.on(.next(()))
    }
    
    func getMovies() {
        guard state == .ready else { return }
        self.state = .loading
        self.movieDataSourceObserver.on(.next(()))
        
        currentPageOfMovies += 1
        
        networkRequestDisposable = networkingService.getMovies(searchQuery: self.entererSearchTerm, page: currentPageOfMovies)
            .subscribe(
                onSuccess: { [weak self] in
                    guard let self = self else { return }
                    self.movies.append(contentsOf: $0.movies)
                    if self.currentPageOfMovies >= $0.totalNumberOfPages {
                        self.state = .allResultsLoaded
                    } else {
                        self.state = .ready
                    }
                    self.movieDataSourceObserver.on(.next(()))
                },
                onFailure: { [weak self] err in
                    guard let self = self else { return }
                    self.state = .error
                    self.movieDataSourceObserver.on(.error((err)))
                }
            )
    }
    
    func loadMoreResults() {
        guard state == .ready, !movies.isEmpty else { return }
        getMovies()
    }
    
    // MARK: - Collection View Data
    func calculateCellSize(collectionViewWidth: CGFloat) -> CGSize {
        let coverAspectRatio = 3.0/2.0
        let totalWidthAfterPadding = collectionViewWidth - collectionViewCellPadding
        let width = totalWidthAfterPadding / numberOfCollectionViewColumns
        let height = width * coverAspectRatio
        return CGSize(width: width, height: height)
    }
}
