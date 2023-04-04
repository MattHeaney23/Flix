//
//  MovieDetails.swift
//  Flix
//
//  Created by Matt on 01/04/2022.
//

import Foundation

struct MovieDetails: Codable {
    var id: Int
    var title: String?
    var overview: String?
    var backdropPath: String?
    var releaseDate: String?
    var rating: Double?
    var posterPath: String?
    
    private enum CodingKeys : String, CodingKey {
        case id, title, overview, backdropPath = "backdrop_path", releaseDate = "release_date", rating = "vote_average", posterPath = "poster_path"
    }
    
    //Multiple inits needed to allow the object to be created via data or base values. This will allow us to mock the object for tests
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try? container.decode(String.self, forKey: .title)
        overview = try? container.decode(String.self, forKey: .overview)
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        rating = try? container.decode(Double.self, forKey: .rating)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
    }
    
    init(id: Int,
         title: String? = nil,
         overview: String? = nil,
         backdropPath: String? = nil,
         releaseDate: String? = nil,
         rating: Double? = nil,
         posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.overview = overview
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.rating = rating
        self.posterPath = posterPath
    }
}
