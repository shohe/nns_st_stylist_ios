//
//  ReservationGetRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct ReservationGetRequest: NNSRequest {
        typealias Response = ReservationGetResponse
        let method: HTTPMethod = .get
        let today: String
        var path: String { return "/api/reservation" }
        var parameters: Any? {
            return ["date_time" : today]
        }
    }
}
