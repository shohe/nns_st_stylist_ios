//
//  ReservationListGetResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct ReservationListGetResponse: Decodable{
    
    let item: [ReservationListGetItem]
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}

struct ReservationListGetItem: Decodable{
    
    let offerId: Int
    let price: Float
    let dateTime: String
    let menu: String
    let imageUrl: String?
    let cxName: String
    
    private enum CodingKeys: String, CodingKey {
        case offerId = "offerId"
        case price = "price"
        case dateTime = "dateTime"
        case menu = "menu"
        case imageUrl = "imageUrl"
        case cxName = "name"
    }
}

