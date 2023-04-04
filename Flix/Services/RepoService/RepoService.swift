//
//  RepoService.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import Foundation

/// A service used to read and write from the user defaults
class RepoService: RepoServiceProtocol {
    //MARK: - Init
    private init() {}
    
    //MARK: - Properties
    static let Shared: RepoServiceProtocol = RepoService()
    private let userDefaults = UserDefaults()
    
    //MARK: - IDs
    private let favouriteMoviesID = "favoriteMovies"
    
    //MARK: - User Favourite Methods
    /// Adds the movieID from the user's stored list of favourite movies
    func addFavouriteMovie(id: Int) {
        if var userFavourites = userDefaults.array(forKey: favouriteMoviesID) as? [Int] {
            userFavourites.append(id)
            userDefaults.set(userFavourites, forKey: favouriteMoviesID)
        } else {
            
            let userFavourites = [id]
            userDefaults.set(userFavourites, forKey: favouriteMoviesID)
        }
    }
    
    /// Remove the movieID from the user's stored list of favourite movies
    func removeFavouriteMove(movieID: Int) {
        guard var userFavourites = userDefaults.array(forKey: favouriteMoviesID) as? [Int],
              let index = userFavourites.firstIndex(of: movieID) else {
                  return
              }
        
        userFavourites.remove(at: index)
        userDefaults.set(userFavourites, forKey: favouriteMoviesID)
    }
    
    /// Returns true or false, depending on if the movie has been favourited
    func isMovieFavourited(_ id: Int) -> Bool {
        guard let usersFavourites = userDefaults.array(forKey: favouriteMoviesID) as? [Int] else {
            return false
        }
        return usersFavourites.contains(id)
    }
}
