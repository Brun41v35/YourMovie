//
//  Movie.swift
//  YourMovie
//
//  Created by Bruno Silva on 02/12/20.
//

import Foundation

struct Movie: Codable{
    
    let backdropPath: String
    let homepage: String
    let originalTitle: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case homepage
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//{
//  "backdrop_path": "/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg",
//  "homepage": "https://www.marvel.com/movies/avengers-endgame",
//  "original_title": "Avengers: Endgame",
//  "popularity": 210.682,
//  "poster_path": "/or06FN3Dka5tukK1e9sl16pB3iy.jpg",
//  "release_date": "2019-04-24",
//  "title": "Avengers: Endgame",
//  "vote_average": 8.3,
//  "vote_count": 15850
//}
