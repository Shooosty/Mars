//
//  JsonParcing.swift
//  Mars
//
//  Created by Macbook on 31/07/2019.
//  Copyright © 2019 Technology&Design LLC. All rights reserved.
//

import Foundation

struct Result: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    let id: Int
    let imgSrc: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imgSrc = "img_src"
    }
}

