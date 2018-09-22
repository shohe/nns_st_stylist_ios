//
//  OwnReviewGetRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct OwnReviewGetRequest: NNSRequest {
        typealias Response = OwnReviewGetResponse
        let method: HTTPMethod = .get
        let id: Int?
        var path: String {
            if let id = id { return "/api/review/\(id)" }
            else { return "/api/review" }
        }
    }
}
