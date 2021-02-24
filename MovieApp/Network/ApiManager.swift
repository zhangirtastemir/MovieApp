//
//  ApiManager.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/7/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import Moya

private let api_url = URL(string: "https://api.themoviedb.org/3")
private let APIKey = "1e83b2d3e2bb3ef86c16c5b101e8e0d6"

enum ApiManager {
    case topRatedMovies(page: Int)
    case upcomingMovies(page: Int)
    case popularMovies(page: Int)
    case nowPlaying(page: Int)
    case latestMovie
    case similarMovies(id: Int)
    case genres
    case videos(id: Int)
    case search(query: String)
}

extension ApiManager: TargetType {
    var baseURL: URL {
        guard let url = api_url else { fatalError("base url could not be configured")}
        return url
    }
    
    var path: String {
        switch self {
        case .topRatedMovies:
            return "movie/top_rated"
        case .upcomingMovies:
            return "movie/upcoming"
        case .popularMovies:
            return "movie/popular"
        case .nowPlaying:
            return "movie/now_playing"
        case .latestMovie:
            return "movie/latest"
        case .similarMovies(let id):
            return "movie/\(id)/similar"
        case .genres:
            return "genre/movie/list"
        case .videos(let id):
            return "movie/\(id)/videos"
        case .search:
            return "search/movie"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .topRatedMovies(let page), .upcomingMovies(let page), .popularMovies(let page), .nowPlaying(let page):
            return .requestParameters(parameters: ["page": page, "api_key": APIKey], encoding: URLEncoding.default)
        case .latestMovie, .genres, .videos, .similarMovies:
            return .requestParameters(parameters: ["api_key": APIKey], encoding: URLEncoding.default)
        case .search(let query):
            return .requestParameters(parameters: ["api_key": APIKey, "query": query], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

