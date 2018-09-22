//
//  OfferHistoryListGetResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct OfferHistoryListGetResponse: Decodable{
    
    let item: [OfferHistoryListGetItem]
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}

struct OfferHistoryListGetItem: Decodable{
    
    let id: Int
    let price: Float
    let dateTime: String
    let menu: String
    let imageUrl: String?
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case price = "price"
        case dateTime = "dateTime"
        case menu = "menu"
        case imageUrl = "imageUrl"
        case name = "name"
    }
}
