//
//  NetworkService.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import Foundation
import RxAlamofire
import RxSwift

/// Local version of NetworkService, returning a local response and not calling off to the API. This will be used for local development, for UITests and Snapshot tests
class NetworkService: NetworkServiceProtocol {
    //MARK: - Init
    private init() {}
    static let Shared: NetworkServiceProtocol = NetworkService()
    
    func getMovies(searchQuery: String? = nil, page: Int) -> Single<MovieResponse> {
        
        if searchQuery != "" {
            return .just(MovieResponse(totalNumberOfPages: 1, movies: []))
        } else {
            return .just(MovieResponse(totalNumberOfPages: 1, movies: LocalResponse.movies))
        }
    }
    
    func getImage(path: String) -> Single<UIImage> {
        guard let image = UIImage(named: "LocalAsset-\(path)") else {
            return .error(LocalNetworkServiceErrors.invalidImagePath)
        }
        return .just(image)
    }
}
