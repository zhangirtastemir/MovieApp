//
//  SectionItem.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 3/9/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import UIKit

class SectionItem: ListItem {
    
    var itemType: ItemType = .section
    
    var label: String!
    
    init(label: String) {
        self.label = label
    }
}
