//
//  ListItem.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/9/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

protocol ListItem {
    var itemType: ItemType { get }
}

enum ItemType {
    case section, movies
}
