//
//  OfferCancelRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct OfferCancelRequest: NNSRequest {
        typealias Response = OfferCancelResponse
        let method: HTTPMethod = .put
        let id: Int
        var path: String { return "/api/offer" }
        var bodyParameters: BodyParameters? {
            var jsonResouce: [String: Any] = [:]
            jsonResouce["id"] = id
            return JSONBodyParameters(JSONObject: jsonResouce)
        }
    }
}
