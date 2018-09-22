//
//  UserRegistResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct UserRegistResponse: Decodable {
    let item: UserRegistItem
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}

struct UserRegistItem: Decodable {

    let token: String
    let userId: Int

    private enum CodingKeys: String, CodingKey {
        case token = "token"
        case userId = "id"
    }
}
