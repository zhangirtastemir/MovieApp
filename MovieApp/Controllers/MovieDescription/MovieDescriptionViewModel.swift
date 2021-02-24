//
//  MovieDescriptionViewModel.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 4/3/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class MovieDescriptionViewModel {

    let movie: Movie
    
    let movieUrl = URL(string: "https://image.tmdb.org/t/p/w780")
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getRenres() -> String {
        var genreNames: [String] = []
        for id in movie.genreIds ?? [] {
            let genres = GenreManager.shared.genres.filter( { $0.id == id } )
            genreNames.append(genres.first?.name ?? "")
        }
        
        let stringRepresentation = genreNames.joined(separator: ", ")
        return stringRepresentation
    }
    
    func getMovieUrl() -> URL? {
        
        if let imagePath = movie.backdropPath, let url = movieUrl?.appendingPathComponent(imagePath) {
            return url
        }
        
        return nil
    }
    
    func loadVideos(completion: @escaping ([Video]) -> Void) {
        NetworkManager.getVideos(id: movie.id) { (videos) in
            completion(videos)
        }
    }
    
    func loadSimilarMovies(completion: @escaping ([Movie]) -> Void) {
        NetworkManager.getSimilarMovies(id: movie.id) { (movies) in
            completion(movies)
        }
    }
    
}
