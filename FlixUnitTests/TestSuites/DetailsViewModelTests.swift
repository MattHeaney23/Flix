//
//  DetailsViewModelTests.swift
//  FlixUnitTests
//
//  Created by Matt on 03/04/2022.
//

@testable import Flix
import XCTest

class DetailsViewModelTests: XCTestCase {
    
    let mockedMovie = MovieDetails(id: 335787,
                                   title: "Uncharted",
                                   overview: "A young street-smart, Nathan Drake and his wisecracking partner Victor “Sully” Sullivan embark on a dangerous pursuit of “the greatest treasure never found” while also tracking clues that may lead to Nathan’s long-lost brother.",
                                   backdropPath: "/geYUecpFI2AonDLhjyK9zoVFcMv.jpg",
                                   releaseDate: "2022-02-10",
                                   rating: 7.1,
                                   posterPath: "/sqLowacltbZLoCa4KYye64RvvdQ.jpg")
    
    var mockedRepoService: MockRepoService!
    var sut: DetailsViewModel!
    
    override func setUp() {
        mockedRepoService = MockRepoService(mockedFavouriteIDs: [])
        sut = DetailsViewModel(movieDetails: mockedMovie,
                               repoService: mockedRepoService)
    }
    
    override func tearDown() {
        mockedRepoService = nil
        sut = nil
    }
    
    //MARK: - Movie Details
    func test_movieReleaseDate_value() {
        //Given
        let actualReleaseDate = sut.movieReleaseDate
        
        //Then
        let expectedReleaseDate = "10 February 2022"
        
        XCTAssertEqual(actualReleaseDate, expectedReleaseDate)
    }
    
    func test_movieRating_value() {
        //Given
        let actualMovieRating = sut.movieRating
        
        //Then
        let expectedMovieRating = "7.1"
        
        XCTAssertEqual(actualMovieRating, expectedMovieRating)
    }
    
    //MARK: - Favouriting Movies
    func test_AddingAndRemovingMoviesFromFavourites() {
        //Given - Movies Starts Not Favourited
        XCTAssertFalse(mockedRepoService.isMovieFavourited(335787))
        
        //When - We Favourite The Movie
        sut.toggleMovieFavourited()
        
        //Then - Movie Should Be Favourited
        XCTAssertTrue(mockedRepoService.isMovieFavourited(335787))
        
        //When - We Unfavourite The Movie
        sut.toggleMovieFavourited()
        
        //Then - Movie Should Not Be Favourited
        XCTAssertFalse(mockedRepoService.isMovieFavourited(335787))
    }
    
}
