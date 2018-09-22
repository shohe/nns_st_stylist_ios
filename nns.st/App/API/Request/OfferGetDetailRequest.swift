//
//  OfferGetDetailRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct OfferGetDetailRequest: NNSRequest {
        typealias Response = OfferGetDetailResponse
        let method: HTTPMethod = .get
        let id: Int
        var path: String { return "/api/offer/\(id)" }
    }
}
