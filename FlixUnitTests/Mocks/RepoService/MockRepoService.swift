//
//  MockRepoService.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

@testable import Flix
import XCTest

/// A service used to read and write from the user defaults
class MockRepoService: RepoServiceProtocol {
    
    var mockedFavouriteIDs: [Int]
    
    init(mockedFavouriteIDs: [Int]) {
        self.mockedFavouriteIDs = mockedFavouriteIDs
    }
    
    /// Adds the movieID from the user's stored list of favourite movies
    func addFavouriteMovie(id: Int) {
        mockedFavouriteIDs.append(id)
    }
    
    /// Remove the movieID from the user's stored list of favourite movies
    func removeFavouriteMove(movieID: Int) {
        guard let index = mockedFavouriteIDs.firstIndex(of: movieID) else {
            XCTFail("ID not in the favourites")
            fatalError()
        }
        
        mockedFavouriteIDs.remove(at: index)
    }
    
    /// Returns true or false, depending on if the movie has been favourited
    func isMovieFavourited(_ id: Int) -> Bool {
        mockedFavouriteIDs.contains(id)
    }
}
