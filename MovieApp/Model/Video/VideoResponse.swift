//
//  VideoResponse.swift
//  MovieApp
//
//  Created by Zhangir Tastemir on 5/6/20.
//  Copyright © 2020 Akysh Akan. All rights reserved.
//

import Foundation

struct VideoResponse {
    var id: Int
    var videos: [Video]
}

extension VideoResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case videos = "results"
    }
}
