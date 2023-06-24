//
//  TV.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/21.
//

import Foundation

struct TVListModel: Decodable {
    let page: Int?
    let tvList: [TV]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case tvList = "results"
    }
}

struct TV: Decodable, Hashable {
    let firstAirDate: String?
    let name: String?
    let overview: String?
    let posterURL: String?
//    let voteAverage: Double?
//    let voteCount: Int?
    let vote: String?

    enum CodingKeys: String, CodingKey {
        case firstAirDate = "first_air_date"
        case name
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        firstAirDate = try container.decode(String.self, forKey: .firstAirDate)
        name = try container.decode(String.self, forKey: .name)
        overview = try container.decode(String.self, forKey: .overview)
        let posterPath = try container.decode(String.self, forKey: .posterPath)
        posterURL = "https://image.tmdb.org/t/p/w500/\(posterPath)"
        let voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        vote = "\(voteAverage)/\(voteCount)"
    }
}
