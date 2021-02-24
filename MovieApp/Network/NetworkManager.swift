//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/7/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import Moya
protocol Networkable {
    static var provider: MoyaProvider<ApiManager> { get }
    static func getTopRatedMovies(page: Int, completion: @escaping ([Movie])->())
}

struct NetworkManager: Networkable {
//    static var provider = MoyaProvider<ApiManager>(plugins: [NetworkLoggerPlugin(verbose: true)])
    static var provider = MoyaProvider<ApiManager>()
    
    static func getTopRatedMovies(page: Int, completion: @escaping ([Movie]) -> ()) {
        provider.request(.topRatedMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    completion(results.movies)
                } catch let error as NSError {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getPopularMovies(page: Int, completion: @escaping ([Movie]) -> ()) {
        provider.request(.popularMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    completion(results.movies)
                } catch let error as NSError {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getUpcomingMovies(page: Int, completion: @escaping ([Movie]) -> ()) {
        provider.request(.upcomingMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    completion(results.movies)
                } catch let error as NSError {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getNowPlayingMovies(page: Int, completion: @escaping ([Movie]) -> ()) {
        provider.request(.nowPlaying(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    completion(results.movies)
                } catch let error as NSError {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getGenres(completion: @escaping ([Genre]) -> ()) {
        provider.request(.genres) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(GenreResponse.self, from: response.data)
                    completion(results.genres)
                } catch let error as NSError {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getVideos(id: Int, completion: @escaping ([Video]) -> ()) {
        provider.request(.videos(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(VideoResponse.self, from: response.data)
                    completion(results.videos)
                } catch let error as NSError {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func searchMovies(query: String, completion: @escaping ([Movie]) -> ()) {
        provider.request(.search(query: query)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    completion(results.movies)
                } catch let error as NSError {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    static func getSimilarMovies(id: Int, completion: @escaping ([Movie]) -> ()) {
        provider.request(.similarMovies(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    completion(results.movies)
                } catch let error as NSError {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }

}
