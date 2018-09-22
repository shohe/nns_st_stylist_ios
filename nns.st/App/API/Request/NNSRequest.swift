//
//  NNSRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/10.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

// * Result * //
enum Result<T> {
    case success(T)
    case failure(Error)
}


// * NNSRequest * //
protocol NNSRequest: Request {
}

extension NNSRequest {
    
    var baseURL: URL {
        return URL(string: "https://nonamesalon.st")!
    }
    
    var headerFields: [String : String] {
        guard let accessToken = NNSCore.authToken() else {
            return [:]
        }
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
}

extension NNSRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if #available(iOS 10.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        } else {
            // Fallbak on earlier versions
        }
        
        // Avoid decording error when "204 no content" etc
        if data.count == 0 {
            let emptyJson = "{}"
            return try decoder.decode(Response.self, from: emptyJson.data(using: .utf8)!)
        } else {
            //  ** for debug ** //
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            print("response JSON: \(json)")
            return try decoder.decode(Response.self, from: data)
        }
    }

}

