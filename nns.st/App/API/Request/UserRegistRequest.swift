//
//  UserRegistRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct UserRegistRequest: NNSRequest {
        typealias Response = UserRegistResponse
        let method: HTTPMethod = .post
        let name: String?
        let email: String?
        let password: String?
        var path: String { return "/api/user" }
        
        var bodyParameters: BodyParameters? {
            var params: [MultipartFormDataBodyParameters.Part] = []
            
            // required params
            guard let name = name else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: name, name: "name"))
            guard let email = email else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: email, name: "email"))
            guard let password = password else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: password, name: "password"))
            
            return MultipartFormDataBodyParameters(parts: params)
        }
    }
}
