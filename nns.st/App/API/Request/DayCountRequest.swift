//
//  DayCountRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct DayCountRequest: NNSRequest {
        typealias Response = DayCountResponse
        let method: HTTPMethod = .get
        let today: String
        var path: String { return "/api/user/daycount" }
        var parameters: Any? {
            return ["date_time" : today]
        }
    }
}
