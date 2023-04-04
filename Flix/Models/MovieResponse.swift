//
//  MovieResponse.swift
//  Flix
//
//  Created by Matt on 03/04/2022.
//

import Foundation

struct MovieResponse: Codable {
    var totalNumberOfPages: Int
    var movies: [MovieDetails]
    
    private enum CodingKeys : String, CodingKey {
        case movies = "results", totalNumberOfPages = "total_pages"
    }
    
    //Multiple inits needed to allow the object to be created via data or base values. This will allow us to mock the object for tests
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        totalNumberOfPages = try container.decode(Int.self, forKey: .totalNumberOfPages)
        movies = try container.decode([MovieDetails].self, forKey: .movies)
    }
    
    init(totalNumberOfPages: Int, movies: [MovieDetails]) {
        self.totalNumberOfPages = totalNumberOfPages
        self.movies = movies
    }
}
