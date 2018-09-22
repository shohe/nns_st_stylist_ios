//
//  OfferCreateResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/01.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct OfferCreateResponse: Decodable {
    
    let item: Offer
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}
