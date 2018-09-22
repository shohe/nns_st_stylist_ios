//
//  OfferHistoryDetailGetRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct OfferHistoryDetailGetRequest: NNSRequest {
        typealias Response = OfferHistoryDetailGetResponse
        let method: HTTPMethod = .get
        let id: Int
        var path: String { return "/api/offerHistory/\(id)" }
    }
}
