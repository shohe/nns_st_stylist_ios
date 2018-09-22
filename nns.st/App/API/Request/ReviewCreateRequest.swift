//
//  ReviewCreateRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct ReviewCreateRequest: NNSRequest {
        typealias Response = ReviewCreateResponse
        let method: HTTPMethod = .post
        let dealUserId: Int
        let star: Int
        let comment: String?
        var path: String { return "/api/review" }
        
        var bodyParameters: BodyParameters? {
            var params: [MultipartFormDataBodyParameters.Part] = []
            
            // required params
            params.append(try! MultipartFormDataBodyParameters.Part(value: dealUserId, name: "deal_user_id"))
            params.append(try! MultipartFormDataBodyParameters.Part(value: star, name: "star"))
            
            if let comment = comment {
                params.append(try! MultipartFormDataBodyParameters.Part(value: comment, name: "comment"))
            }
            
            return MultipartFormDataBodyParameters(parts: params)
        }
    }
}
