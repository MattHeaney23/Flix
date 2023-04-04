//
//  RepoServiceProtocol.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import Foundation

protocol RepoServiceProtocol {
    func addFavouriteMovie(id: Int)
    func removeFavouriteMove(movieID: Int)
    func isMovieFavourited(_ id: Int) -> Bool
}
