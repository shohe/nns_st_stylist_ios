//
//  OfferRequireMatchedResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct OfferRequireMatchedResponse: Decodable {
    
    let located: [OfferRequireMatchedItem]
    let nominated: [OfferRequireMatchedItem]
    
    private enum CodingKeys: String, CodingKey {
        case located = "located"
        case nominated = "nominated"
    }
}

struct OfferRequireMatchedItem: Decodable {
    
    let offerId: Int
    let name: String
    let imageUrl: String?
    // api doesn't have this parameter
    // its used for tableView dataSource
    var isNominated: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case offerId = "offerId"
        case name = "name"
        case imageUrl = "imageUrl"
        case isNominated = "-"
    }
}
