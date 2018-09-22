//
//  OwnReviewGetResponse.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

struct OwnReviewGetResponse: Decodable{
    
    let item: [OwnReviewGetItem]
    let evaluate: EvaluateItem
    let user: UserItem
    
    private enum CodingKeys: String, CodingKey {
        case item = "success"
        case evaluate = "evaluate"
        case user = "user"
    }
}

struct OwnReviewGetItem: Decodable{
    
    let writerName: String
    let star: Int
    let comment: String?
    let dateTime: String?
    
    private enum CodingKeys: String, CodingKey {
        case writerName = "writerName"
        case star = "star"
        case comment = "comment"
        case dateTime = "createdAt"
    }
}

struct EvaluateItem: Decodable{
    
    let average: Float
    let one: Int
    let two: Int
    let three: Int
    let four: Int
    let five: Int
    
    private enum CodingKeys: String, CodingKey {
        case average = "average"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
    }
}

struct UserItem: Decodable{
    
    let imageUrl: String?
    let star: Int
    let statusComment: String?
    let salonName: String?
    let salonAddress: String?
    let salonLocation: SalonLocation?
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "imageUrl"
        case star = "star"
        case statusComment = "statusComment"
        case salonName = "salonName"
        case salonAddress = "salonAddress"
        case salonLocation = "salonLocation"
    }
}
