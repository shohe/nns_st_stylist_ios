//
//  User.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct User: Decodable {
    var id: Int?
    var name: String?
    var email: String?
    var password: String?
    var imageUrl: String?
    var statusComment: String?
    var isStylist: Int?
    var salonName: String?
    var salonAddress: String?
    var salonLocationLat: Double?
    var salonLocationLng: Double?
    var salonLocation: SalonLocation?

    init() {}

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case password = "password"
        case imageUrl = "imageUrl"
        case statusComment = "statusComment"
        case isStylist = "isStylist"
        case salonName = "salonName"
        case salonAddress = "salonAddress"
        case salonLocationLat = "salonLocationLat"
        case salonLocationLng = "salonLocationLng"
        case salonLocation = "salonLocation"
    }
}

struct SalonLocation: Decodable {
    let lat: Double
    let lng: Double
    
    private enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lng = "lng"
    }
}
