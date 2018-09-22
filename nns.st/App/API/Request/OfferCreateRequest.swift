//
//  OfferCreateRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/01.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct OfferCreateRequest: NNSRequest {
        typealias Response = OfferCreateResponse
        let method: HTTPMethod = .post
        let offer: Offer?
        var path: String { return "/api/offer" }
        
        var bodyParameters: BodyParameters? {
            var params: [MultipartFormDataBodyParameters.Part] = []
            
            // required params
            guard let menu = offer?.menu else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: menu, name: "menu"))
            guard let price = offer?.price else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: price, name: "price"))
            guard let dateTime = offer?.dateTime else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: dateTime, name: "date_time"))
            guard let hairType = offer?.hairType else { return nil }
            params.append(try! MultipartFormDataBodyParameters.Part(value: hairType, name: "hair_type"))
            
            if let stylistId = offer?.stylistId {
                params.append(try! MultipartFormDataBodyParameters.Part(value: stylistId, name: "stylist_id"))
            } else {
                guard let distanceRange = offer?.distanceRange else { return nil }
                params.append(try! MultipartFormDataBodyParameters.Part(value: distanceRange, name: "distance_range"))
                guard let fromLocationLat = offer?.fromLocationLat else { return nil }
                params.append(try! MultipartFormDataBodyParameters.Part(value: fromLocationLat, name: "from_location_lat"))
                guard let fromLocationLng = offer?.fromLocationLng else { return nil }
                params.append(try! MultipartFormDataBodyParameters.Part(value: fromLocationLng, name: "from_location_lng"))
            }
            
            if let comment = offer?.comment {
                params.append(try! MultipartFormDataBodyParameters.Part(value: comment, name: "comment"))
            }
            
            return MultipartFormDataBodyParameters(parts: params)
        }
    }
}
