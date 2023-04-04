//
//  MovieCellViewModel.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import RxSwift
import Foundation

class MovieCellViewModel {
    //MARK: - Properties
    var movie: MovieDetails
    var isMoveFavourited: Bool {
        repoService.isMovieFavourited(self.movie.id)
    }
    
    //MARK: - Service Dependancies
    private let repoService: RepoServiceProtocol
    private let networkingService: NetworkServiceProtocol
    
    //MARK: - Subscriptions
    let favouriteStateChange = PublishSubject<()>()
    private let disposeBag = DisposeBag()
    
    //MARK: - Setup
    ///Initialise MovieCellViewModel. repoService defaults to 'RepoServiceProtocol.Shared' if no value set. This allows for injecting mocked versions of the service
    init(movie: MovieDetails,
         repoService: RepoServiceProtocol = RepoService.Shared,
         networkingService: NetworkServiceProtocol = NetworkService.Shared
    ) {
        self.movie = movie
        self.repoService = repoService
        self.networkingService = networkingService
    }
    
    //MARK: - User Favourites
    @objc
    func toggleFavouriteMovie() {
        if repoService.isMovieFavourited(movie.id) {
            repoService.removeFavouriteMove(movieID: movie.id)
        } else {
            repoService.addFavouriteMovie(id: movie.id)
        }
        
        favouriteStateChange.on(.next(()))
    }
    
    //MARK: - Network Requests
    func getMovieCover() -> Single<UIImage>? {
        if let imagePath = self.movie.posterPath {
            return networkingService.getImage(path: imagePath)
        } else {
            return nil
        }
    }
}
