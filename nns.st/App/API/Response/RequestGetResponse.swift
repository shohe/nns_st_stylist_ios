//
//  RequestGetResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct RequestGetResponse: Decodable {
    
    let item: [RequestGetItem]
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
    }
}

struct RequestGetItem: Decodable {
    
    let requestId: Int
    let name: String
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case requestId = "requestId"
        case name = "name"
        case imageUrl = "imageUrl"
    }
}
