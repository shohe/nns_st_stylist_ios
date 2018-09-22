//
//  UserGetRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/01.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct UserGetRequest: NNSRequest {
        typealias Response = UserGetResponse
        let method: HTTPMethod = .get
        var path: String { return "/api/user" }
    }
}
