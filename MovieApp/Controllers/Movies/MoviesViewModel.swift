//
//  MovieDescriptionViewModel.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/13/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class MoviesViewModel {
    var title: String
    
    var movies = [Movie]()
    
    init(title: String) {
        self.title = title
    }
}
