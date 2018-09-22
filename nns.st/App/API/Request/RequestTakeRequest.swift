//
//  RequestTakeRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct RequestTakeRequest: NNSRequest {
        typealias Response = RequestTakeResponse
        let method: HTTPMethod = .put
        let id: Int
        var path: String { return "/api/request/\(id)" }
    }
}
