//
//  OfferGetDetailResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct OfferGetDetailResponse: Decodable {
    
    let item: OfferGetDetailItem
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}

struct OfferGetDetailItem: Decodable {
    
    let id: Int
    let cxId: Int
    let cxName: String
    let cxImageUrl: String?
    let cxStatusComment: String
    let cxStar: Int?
    let menu: String
    let price: Float
    let dateTime: String
    let distanceRange: Float?
    let fromLocation: FromLocation?
    let stylistId: Int?
    let hairType: HairType.RawValue
    let comment: String?
    let isClosed: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case cxId = "cxId"
        case cxName = "cxName"
        case cxImageUrl = "cxImageUrl"
        case cxStatusComment = "cxStatusComment"
        case cxStar = "average"
        case menu = "menu"
        case price = "price"
        case dateTime = "dateTime"
        case distanceRange = "distanceRange"
        case fromLocation = "fromLocation"
        case stylistId = "stylistId"
        case hairType = "hairType"
        case comment = "comment"
        case isClosed = "isClosed"
    }
}
