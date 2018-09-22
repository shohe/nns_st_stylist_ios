//
//  PasswordConfirmRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct PasswordConfirmRequest: NNSRequest {
        typealias Response = PasswordConfirmResponse
        let method: HTTPMethod = .post
        let password: String?
        let c_password: String?
        var path: String { return "/api/user/password" }
        
        var bodyParameters: BodyParameters? {
            var params: [MultipartFormDataBodyParameters.Part] = []
            
            // required params
            guard let password = password else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: password, name: "password"))
            guard let c_password = c_password else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: c_password, name: "c_password"))
            
            return MultipartFormDataBodyParameters(parts: params)
        }
    }
}
