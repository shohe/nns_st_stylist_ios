//
//  UserUpdateRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct UserUpdateRequest: NNSRequest {
        typealias Response = UserUpdateResponse
        let method: HTTPMethod = .put
        let user: User?
        var path: String { return "/api/user" }
        
        var bodyParameters: BodyParameters? {
            guard let user = user else { return nil }
            var jsonResouce: [String: Any] = [:]
            
            if let name = user.name { jsonResouce["name"] = name }
            if let email = user.email { jsonResouce["email"] = email }
            if let password = user.password { jsonResouce["password"] = password }
            if let imageUrl = user.imageUrl { jsonResouce["image_url"] = imageUrl }
            if let statusComment = user.statusComment {
                if statusComment != "" {
                    jsonResouce["status_comment"] = statusComment
                }
            }
            if let isStylist = user.isStylist { jsonResouce["is_stylist"] = isStylist }
            if let salonName = user.salonName { jsonResouce["salon_name"] = salonName }
            if let salonAddress = user.salonAddress { jsonResouce["salon_address"] = salonAddress }
            if let salonLocationLat = user.salonLocationLat { jsonResouce["salon_location_lat"] = salonLocationLat }
            if let salonLocationLng = user.salonLocationLng { jsonResouce["salon_location_lng"] = salonLocationLng }
            
            return JSONBodyParameters(JSONObject: jsonResouce)
        }
    }
}
