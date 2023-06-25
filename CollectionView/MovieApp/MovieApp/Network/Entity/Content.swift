//
//  Content.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/24.
//

import Foundation


struct Content: Decodable, Hashable {
    let name: String?
    let overview: String?
    let posterURL: String?
    let vote: String?
    
    init(tv: TV) {
        self.name = tv.name
        self.overview = tv.overview
        self.posterURL = tv.posterURL
        self.vote = tv.vote
    }
    
    init(movie: Movie) {
        self.name = movie.name
        self.overview = movie.overview
        self.posterURL = movie.posterURL
        self.vote = movie.vote
    }
}
