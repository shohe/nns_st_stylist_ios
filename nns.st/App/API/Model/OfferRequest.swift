//
//  OfferRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct OfferRequest: Decodable {
    
    let id: Int
    let offerId: Int
    let stylistId: Int
    let price: Float
    let comment: String
    let isMatched: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case offerId = "offerId"
        case stylistId = "stylistId"
        case price = "price"
        case comment = "comment"
        case isMatched = "isMatched"
    }
    
}
