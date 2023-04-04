//
//  MainViewModelTests.swift
//  FlixUnitTests
//
//  Created by Matt on 03/04/2022.
//

@testable import Flix
import XCTest

class MainViewModelTests: XCTestCase {
    
    //Using a function rather than setUp to allow config to be passed to the sut
    func getViewModelWithMockedNetworkService(networkService: MockNetworkServiceResponse,
                                              moviesInResponse: Int?,
                                              totalNumberOfPagesInResponse: Int?) -> MainViewModel {
        let mockNetworkService = MockNetworkService(mockNetworkServiceResponse: networkService,
                                                    moviesInResponse: moviesInResponse,
                                                    totalNumberOfPagesInResponse: totalNumberOfPagesInResponse)
        
        return MainViewModel(networkingService: mockNetworkService)
    }
    
    //MARK: - States
    
    func testState_IsReady_OnLaunch() {
        //Given
        let sut = MainViewModel()
        
        //Then
        let expectedState: MainViewModelState = .ready
        let actualState = sut.state
        
        XCTAssertEqual(expectedState, actualState)
    }
    
    func testState_IsReady_OnLoadFinished_MoreResultsAvailable() {
        //Given
        let sut = getViewModelWithMockedNetworkService(networkService: .success,
                                                       moviesInResponse: 40,
                                                       totalNumberOfPagesInResponse: 3)
        
        sut.currentPageOfMovies = 1
        
        //When
        sut.getMovies()
        
        //Then
        let expectedState: MainViewModelState = .ready
        let actualState = sut.state
        
        XCTAssertEqual(expectedState, actualState)
    }
    
    func testState_IsAllResultsLoaded_OnLoadFinished_AllResults() {
        //Given
        let sut = getViewModelWithMockedNetworkService(networkService: .success,
                                                       moviesInResponse: 20,
                                                       totalNumberOfPagesInResponse: 4)
        
        sut.currentPageOfMovies = 3
        
        //When
        sut.getMovies()
        
        //Then
        let expectedState: MainViewModelState = .allResultsLoaded
        let actualState = sut.state
        
        XCTAssertEqual(expectedState, actualState)
    }
    
    func testState_IsAllResultsError_OnErrorFromRequest() {
        
        //Given
        let sut = getViewModelWithMockedNetworkService(networkService: .error,
                                                       moviesInResponse: nil,
                                                       totalNumberOfPagesInResponse: nil)
        //When
        sut.getMovies()
        
        //Then
        let expectedState: MainViewModelState = .error
        let actualState = sut.state
        
        XCTAssertEqual(expectedState, actualState)
        
    }
    
    //MARK: - Appending Moves
    func testMovies_arrayStartsEmpty() {
        //Given
        let sut = MainViewModel()
        //Then
        let expectedNumberOfMoviesInArray = 0
        let actualNumberOfMoviesInArray = sut.movies.count
        
        XCTAssertEqual(expectedNumberOfMoviesInArray, actualNumberOfMoviesInArray)
    }
    
    //MARK: - Preparing For New Results
    
    func testMovies_CleanOnPrepareForNewResults() {
        //Given
        let sut = MainViewModel()
        sut.currentPageOfMovies = 10
        sut.state = .error
        sut.movies.append(MovieDetails(id: 1))
        
        //When
        sut.prepareForNewResults()
        
        //Then
        XCTAssertEqual(sut.currentPageOfMovies, 0)
        XCTAssertEqual(sut.state, .ready)
        XCTAssertEqual(sut.movies.count, 0)
    }
    
    func testMovies_MoviesAppendedOnGet() {
        //Given
        let sut = getViewModelWithMockedNetworkService(networkService: .success,
                                                       moviesInResponse: 123,
                                                       totalNumberOfPagesInResponse: 4)
        
        //When
        sut.getMovies()
        
        //Then
        let expectNumberOfMovies = 123
        let actualNumberOfMovies = sut.movies.count
        
        XCTAssertEqual(expectNumberOfMovies, actualNumberOfMovies)
    }
    
    //MARK: - Collection View Values
    
    func testCellSizeCalculation() {
        //Given
        let sut = MainViewModel()
        
        //When and Then
        XCTAssertEqual(sut.calculateCellSize(collectionViewWidth: 100), CGSize(width: 28, height: 42))
        XCTAssertEqual(sut.calculateCellSize(collectionViewWidth: 1000), CGSize(width: 328, height: 492))
        XCTAssertEqual(sut.calculateCellSize(collectionViewWidth: 10000), CGSize(width: 3328, height: 4992))
    }
    
}
