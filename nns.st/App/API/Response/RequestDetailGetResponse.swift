//
//  RequestDetailGetResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct RequestDetailGetResponse: Decodable {
    
    let request: OfferRequest
    let stylist: User
    let reviews: [Review]
    let average: Float
    
    private enum CodingKeys: String, CodingKey {
        case request = "success"
        case stylist = "stylist"
        case reviews = "reviews"
        case average = "average"
    }
}
