//
//  MockNetworkService.swift
//  FlixUnitTests
//
//  Created by Matt on 03/04/2022.
//

@testable import Flix
import Foundation
import RxSwift
import XCTest

class MockNetworkService: NetworkServiceProtocol {
    
    var mockNetworkServiceResponse: MockNetworkServiceResponse
    var moviesInResponse: Int?
    var totalNumberOfPagesInResponse: Int?
    
    init(mockNetworkServiceResponse: MockNetworkServiceResponse,
         moviesInResponse: Int?,
         totalNumberOfPagesInResponse: Int?) {
        self.mockNetworkServiceResponse = mockNetworkServiceResponse
        self.moviesInResponse = moviesInResponse
        self.totalNumberOfPagesInResponse = totalNumberOfPagesInResponse
    }
    
    func getMovies(searchQuery: String?, page: Int) -> Single<MovieResponse> {
        
        switch self.mockNetworkServiceResponse {
        case .success:
            if let moviesInResponse = moviesInResponse,
               let totalNumberOfPagesInResponse = totalNumberOfPagesInResponse {
                
                var movies: [MovieDetails] = []
                
                for i in 0..<moviesInResponse {
                    movies.append(MovieDetails(id: i))
                }
                
                return .just(MovieResponse(totalNumberOfPages: totalNumberOfPagesInResponse, movies: movies))
            } else {
                XCTFail("Invalid Test Config")
                fatalError()
            }
        case .error:
            return .error(MockNetworkServiceResponseErrors.mockFailed)
        }
    }
    
    func getImage(path: String) -> Single<UIImage> {
        return .just(UIImage())
    }
}
