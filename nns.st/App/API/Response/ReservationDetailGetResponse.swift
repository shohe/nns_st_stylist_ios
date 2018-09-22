//
//  ReservationDetailGetResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct ReservationDetailGetResponse: Decodable{
    
    let item: ReservationGetItem
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}
