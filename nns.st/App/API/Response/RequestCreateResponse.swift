//
//  RequestCreateResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct RequestCreateResponse: Decodable {
    
    let item: RequestCreateItem
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}

struct RequestCreateItem: Decodable {
    
    let id: Int
    let offerId: Int
    let price: Float
    let comment: String
    let stylistId: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case offerId = "offerId"
        case price = "price"
        case comment = "comment"
        case stylistId = "stylistId"
    }
}
