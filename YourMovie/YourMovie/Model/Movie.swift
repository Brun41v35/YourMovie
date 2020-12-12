//
//  Movie.swift
//  YourMovie
//
//  Created by Bruno Silva on 02/12/20.
//

import Foundation

struct Movie: Codable {
    let homepage: String
    let popularity: Double
    let posterPath: String
    let title: String
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case popularity
        case posterPath = "poster_path"
        case title
        case voteCount = "vote_count"
    }
}

struct SimilarMovie: Codable {
    let results: [Results]
}

struct Results: Codable {
    let posterPath: String
    let title: String
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
    }
}
