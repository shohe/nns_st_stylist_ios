//
//  EmailExistRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct EmailExistRequest: NNSRequest {
        typealias Response = EmailExistResponse
        let method: HTTPMethod = .post
        let email: String?
        var path: String { return "/api/user/email" }
        
        var bodyParameters: BodyParameters? {
            var params: [MultipartFormDataBodyParameters.Part] = []
            
            // required params
            guard let email = email else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: email, name: "email"))
            
            return MultipartFormDataBodyParameters(parts: params)
        }
    }
}
