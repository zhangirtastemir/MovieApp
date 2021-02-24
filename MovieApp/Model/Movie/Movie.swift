//
//  Movie.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/7/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import Foundation

struct Movie {
    //required
    var id: Int
    var title: String
    
    //optional
    var popularity: Double?
    var voteCount: Int?
    var overview: String?
    var releaseDate: String?
    var averageVote: Double?
    var posterPath: String?
    var backdropPath: String?
    var genreIds: [Int]?
    var isVideo: Bool?
    var isAdult: Bool?
    
}

extension Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case popularity
        case voteCount = "vote_count"
        case overview
        case releaseDate = "release_date"
        case averageVote = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case isVideo = "video"
        case isAdult = "adult"
    }
}

// json model

//"popularity": 28.357,
//"vote_count": 11508,
//"video": false,
//"poster_path": "/d4KNaTrltq6bpkFS01pYtyXa09m.jpg",
//"id": 238,
//"adult": false,
//"backdrop_path": "/6xKCYgH16UuwEGAyroLU6p8HLIn.jpg",
//"original_language": "en",
//"original_title": "The Godfather",
//"genre_ids": [
//    80,
//    18
//],
//"title": "The Godfather",
//"vote_average": 8.7,
//"overview": "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
//"release_date": "1972-03-14"

