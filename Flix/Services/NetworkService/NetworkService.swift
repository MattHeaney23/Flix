//
//  NetworkService.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import Foundation
import RxAlamofire
import RxSwift

class NetworkService: NetworkServiceProtocol {
    //MARK: - Init
    private init() {}
    static let Shared: NetworkServiceProtocol = NetworkService()
    
    //MARK: - Properties
    private let apiKey = "495a3dc8b3ecf0764a24b85647c846bd"
    private let imageCacheService = ImageCacheService.Shared
    
    //MARK: - Requests
    ///Requests movies to show. If searchQuery is nil, then latest movies currently showing will be requested.
    func getMovies(searchQuery: String? = nil,
                   page: Int) -> Single<MovieResponse> {
        var movieRequestURL: String {
            if let searchQuery = searchQuery, searchQuery != "" {
                let query = searchQuery.replacingOccurrences(of: " ", with: "%20")
                
                let url =  "http://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(query)&page=\(page)"
                
                return url
            } else {
                return "http://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&page=\(page)"
            }
        }
        
        return RxAlamofire.data(.get, movieRequestURL)
            .compactMap({ data in
                let decoder = JSONDecoder()
                return try decoder.decode(MovieResponse.self, from: data)
            }).asSingle()
    }
    
    ///Requests image to show, first checking the cache.
    func getImage(path: String) -> Single<UIImage> {
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(path)") else {
            return .error(NetworkServiceError.invalidURL)
        }
        
        if let cachedImage = imageCacheService.loadImageFromCacheIfAvailable(url: imageURL) {
            return .just(cachedImage)
        } else {
            return RxAlamofire.data(.get, imageURL)
                .compactMap({ data in
                    let image = UIImage(data: data)
                    self.imageCacheService.storeImageInCache(image: image, url: imageURL)
                    return UIImage(data: data)
                }).asSingle()
        }
    }
}
