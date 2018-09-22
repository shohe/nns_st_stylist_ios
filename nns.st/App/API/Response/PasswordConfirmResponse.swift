//
//  PasswordConfirmResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct PasswordConfirmResponse: Decodable {
    
    let password: String
    
    private enum CodingKeys: String, CodingKey {
        case password = "success"
    }
}
