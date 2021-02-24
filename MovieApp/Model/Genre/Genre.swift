//
//  Genre.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 5/1/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import Foundation

struct Genre: Codable {
    var id: Int?
    var name: String?
}

struct GenreResponse: Codable {
    var genres: [Genre]
}
