//
//  LoginResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct LoginResponse: Decodable {
    
    let item: LoginItem
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}

struct LoginItem: Decodable {
    
    let token: String
    
    private enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}
