//
//  NetworkServiceProtocol.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import RxAlamofire
import RxSwift

protocol NetworkServiceProtocol {
    func getMovies(searchQuery: String?, page: Int) -> Single<MovieResponse>
    func getImage(path: String) -> Single<UIImage>
}
