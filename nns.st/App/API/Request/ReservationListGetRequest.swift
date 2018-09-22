//
//  ReservationListGetRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct ReservationListGetRequest: NNSRequest {
        typealias Response = ReservationListGetResponse
        let method: HTTPMethod = .get
        var path: String { return "/api/reservationList" }
    }
}
