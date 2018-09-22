//
//  UserImageUploadResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/08.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct UserImageUploadResponse: Decodable{
    
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case url = "success"
    }
}
