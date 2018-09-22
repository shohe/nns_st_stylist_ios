//
//  DayCountResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct DayCountResponse: Decodable {
    
    let count: Int
    let originalDate: String?
    let isMatched: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case count = "success"
        case originalDate = "origin"
        case isMatched = "matched"
    }
}
