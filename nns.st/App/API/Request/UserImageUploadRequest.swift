//
//  UserImageUploadRequest.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/08.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

extension API {
    struct UserImageUploadRequest: NNSRequest {
        typealias Response = UserImageUploadResponse
        let method: HTTPMethod = .post
        let image: UIImage
        let fileName: String
        var path: String { return "/api/user/image" }
        var bodyParameters: BodyParameters? {
            var params: [MultipartFormDataBodyParameters.Part] = []
            let imageData = UIImageJPEGRepresentation(image, 1.0)
            if let data = imageData {
                params.append(MultipartFormDataBodyParameters.Part(data: data, name: "image", mimeType: "image/jpg", fileName: fileName))
            }
            return MultipartFormDataBodyParameters(parts: params)
        }
    }
}

