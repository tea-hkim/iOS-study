//
//  Movie.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/21.
//

import Foundation

struct MovieListModel: Decodable {
    let page: Int?
    let movieList: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case movieList = "results"
    }
}

struct Movie: Decodable {
    let overview: String?
    let popularity: Double?
    let posterURL: String?
    let releaseDate, title: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        let posterPath = try container.decode(String.self, forKey: .posterPath)
        posterURL = "https://image.tmdb.org/t/p/w500/\(posterPath)"
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        title = try container.decode(String.self, forKey: .title)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
}
