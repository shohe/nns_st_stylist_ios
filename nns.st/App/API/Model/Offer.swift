//
//  Offer.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/01.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct Offer: Decodable {
    var id: Int?
    let menu: String
    let price: Float
    let dateTime: String
    var stylistId: Int?
    var distanceRange: Float?
    var fromLocationLat: Double?
    var fromLocationLng: Double?
    var fromLocation: FromLocation?
    let hairType: HairType.RawValue
    var comment: String?
    
    init(menu: String, price: Float, dateTime: String, hairType: HairType) {
        self.menu = menu
        self.price = price
        self.dateTime = dateTime
        self.hairType = hairType.rawValue
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case menu = "menu"
        case price = "price"
        case dateTime = "dateTime"
        case stylistId = "stylistId"
        case distanceRange = "distanceRange"
        case fromLocationLat = "fromLocationLat"
        case fromLocationLng = "fromLocationLng"
        case fromLocation = "fromLocation"
        case hairType = "hairType"
        case comment = "comment"
    }
}

struct FromLocation: Decodable {
    let lat: Double
    let lng: Double
    
    private enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}
