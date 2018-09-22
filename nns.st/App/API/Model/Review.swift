//
//  Review.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct Review: Decodable {

    let id: Int
    let name: String?
    let star: Int
    let comment: String?
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case star = "star"
        case comment = "comment"
        case date = "createdAt"
    }
}
