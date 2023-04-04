//
//  DetailsViewModel.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import RxSwift
import UIKit

class DetailsViewModel {
    
    //MARK: - Properties
    var movieDetails: MovieDetails
    
    var isMovieFavourited: Bool {
        return repoService.isMovieFavourited(movieDetails.id)
    }
    
    var movieRating: String {
        if let rating = self.movieDetails.rating {
            return "\(rating)"
        } else {
            return "Unavailable"
        }
    }
    
    var movieReleaseDate: String {
        if let releaseDate = self.movieDetails.releaseDate {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: releaseDate) {
                dateFormatter.dateFormat = "dd MMMM yyyy"
                return dateFormatter.string(from: date)
            } else {
                return "Unavailable"
            }
        } else {
            return "Unavailable"
        }
    }
    
    //MARK: - Subscriptions
    private let disposeBag = DisposeBag()
    let favouriteStateChange = PublishSubject<()>()
    
    //MARK: - Service Dependancies
    let networkingService: NetworkServiceProtocol
    let repoService: RepoServiceProtocol
    
    //MARK: - View Launch
    ///Initialise MainViewModel. networkingService defaults to 'NetworkService.Shared' if no value set.  repoService defaults to 'RepoService.Shared'. This allows for injecting mocked versions of the service
    init(movieDetails: MovieDetails,
         networkingService: NetworkServiceProtocol = NetworkService.Shared,
         repoService: RepoServiceProtocol = RepoService.Shared) {
        self.movieDetails = movieDetails
        self.networkingService = networkingService
        self.repoService = repoService
    }
    
    //MARK: - UI
    @objc
    func toggleMovieFavourited() {
        if repoService.isMovieFavourited(self.movieDetails.id) {
            repoService.removeFavouriteMove(movieID: self.movieDetails.id)
        } else {
            repoService.addFavouriteMovie(id: self.movieDetails.id)
        }
        
        favouriteStateChange.onNext(())
    }
    
    //MARK: - Subscriptions
    func getMovieCover() -> Single<UIImage>? {
        if let backdropPath = self.movieDetails.backdropPath {
            return networkingService.getImage(path: backdropPath)
        } else {
            return nil
        }
    }
}
