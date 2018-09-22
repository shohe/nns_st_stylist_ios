//
//  UserGetResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/01.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct UserGetResponse: Decodable {
    
    let item: User
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}
