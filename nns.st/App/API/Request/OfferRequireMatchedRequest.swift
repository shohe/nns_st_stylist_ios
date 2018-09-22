//
//  OfferRequireMatchedRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct OfferRequireMatchedRequest: NNSRequest {
        typealias Response = OfferRequireMatchedResponse
        let method: HTTPMethod = .get
        var path: String { return "/api/offer" }
    }
}
