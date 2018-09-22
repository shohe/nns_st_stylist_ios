//
//  RequestCreateRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct RequestCreateRequest: NNSRequest {
        typealias Response = RequestCreateResponse
        let method: HTTPMethod = .post
        let offerId: Int?
        let price: Float?
        let comment: String?
        var path: String { return "/api/request" }
        
        var bodyParameters: BodyParameters? {
            var params: [MultipartFormDataBodyParameters.Part] = []
            
            // required params
            guard let offerId = offerId else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: offerId, name: "offer_id"))
            guard let price = price else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: price, name: "price"))
            
            if let comment = comment {
                params.append(try! MultipartFormDataBodyParameters.Part(value: comment, name: "comment"))
            }
            
            return MultipartFormDataBodyParameters(parts: params)
        }
    }
}
