//
//  OfferCancelResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct OfferCancelResponse: Decodable{
    
    let result: Bool
    
    private enum CodingKeys: String, CodingKey {
        case result = "success"
    }
}
