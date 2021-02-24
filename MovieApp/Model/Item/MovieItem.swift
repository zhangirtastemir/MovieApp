//
//  MovieItem.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/9/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class MovieItem: ListItem {
    
    var itemType: ItemType = .movies
    
    var movies = [Movie]()
    
    init(movies: [Movie]) {
        self.movies = movies
    }
}
