//
//  API.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import APIKit

//import Alamofire
//import BrightFutures

/// NNSAPI
final class API {
    private init() {}
}

// MARK: - api for User
extension API {
    
    /** return EmailExistResponse
     *   API.emailExistRequest(email: "shohe@gmail.com") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func emailExistRequest(email: String, handler: @escaping (EmailExistResponse?) -> Void){
        Session.send(API.EmailExistRequest(email: email)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: emailExistRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return PasswordConfirmResponse
     *   API.passwordConfirmRequest(password: "password1234", c_password: "password1234") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func passwordConfirmRequest(password: String, c_password: String, handler: @escaping (PasswordConfirmResponse?) -> Void){
        Session.send(API.PasswordConfirmRequest(password: password, c_password: c_password)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: passwordConfirmRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return UserRegistResponse
     *   API.userRegistRequest(name: "test5", email: "test5@gmail.com", password: "testtest") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func userRegistRequest(name: String, email: String, password: String, handler: @escaping (UserRegistResponse?) -> Void){
        Session.send(API.UserRegistRequest(name: name, email: email, password: password)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: userRegistRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return LoginResponse
     *   API.loginRequest(email: "test5@gmail.com", password: "testtest") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func loginRequest(email: String, password: String, handler: @escaping (LoginResponse?) -> Void){
        Session.send(API.LoginRequest(email: email, password: password)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: loginRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return UserUpdateResponse
     *   API.userUpdateRequest(user: user) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func userUpdateRequest(user: User?, handler: @escaping (UserUpdateResponse?) -> Void){
        Session.send(API.UserUpdateRequest(user: user)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: userUpdateRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return User
     *   API.userGetRequest { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func userGetRequest(handler: @escaping (UserGetResponse?) -> Void){
        Session.send(API.UserGetRequest()) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: userGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return DayCountResponse
     *   API.dayCountRequest(today: "2018-08-23 11:00:00") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func dayCountRequest(today: String, handler: @escaping (DayCountResponse?) -> Void){
        Session.send(API.DayCountRequest(today: today)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: dayCountRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return ReservationGetResponse
     *   API.reservationGetRequest(today: "2018-08-23 11:00:00") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func reservationGetRequest(today: String, handler: @escaping (ReservationGetResponse?) -> Void){
        Session.send(API.ReservationGetRequest(today: today)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: reservationGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return ReservationGetResponse
     *   API.reservationDetailGetRequest(id: 1) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func reservationDetailGetRequest(id: Int, handler: @escaping (ReservationGetResponse?) -> Void){
        Session.send(API.ReservationDetailGetRequest(id: id)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: reservationDetailGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    
    /** return UserImageUploadResponse
     *   API.reservationDetailGetRequest(id: 1) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func userImageUploadRequest(image: UIImage, fileName: String, handler: @escaping (UserImageUploadResponse?) -> Void){
        Session.send(API.UserImageUploadRequest(image: image, fileName: fileName)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: userImageUploadRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
}

// MARK: - api for Offer
extension API {
    
    /** return OfferCreateResponse
     *   API.offerCreateRequest(offer: offer) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func offerCreateRequest(offer: Offer, handler: @escaping (OfferCreateResponse?) -> Void){
        Session.send(API.OfferCreateRequest(offer: offer)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: offerCreateRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return OfferRequireMatchedResponse
     *   API.offerRequireMatchedRequest { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func offerRequireMatchedRequest(handler: @escaping (OfferRequireMatchedResponse?) -> Void){
        Session.send(API.OfferRequireMatchedRequest()) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: offerRequireMatchedRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return OfferGetDetailResponse
     *   API.offerGetDetailRequest(id: 8) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func offerGetDetailRequest(id: Int, handler: @escaping (OfferGetDetailResponse?) -> Void){
        Session.send(API.OfferGetDetailRequest(id: id)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: offerGetDetailRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return OfferHistoryListGetResponse
     *   API.offerHistoryListGetRequest() { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func offerHistoryListGetRequest(handler: @escaping (OfferHistoryListGetResponse?) -> Void){
        Session.send(API.OfferHistoryListGetRequest()) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: offerHistoryListGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return OfferHistoryDetailGetResponse
     *   API.offerHistoryDetailGetRequest(id: 1) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func offerHistoryDetailGetRequest(id: Int, handler: @escaping (OfferHistoryDetailGetResponse?) -> Void){
        Session.send(API.OfferHistoryDetailGetRequest(id: id)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: offerHistoryDetailGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return OfferCancelResponse
     *   API.offerCancelRequest(id: 1) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func offerCancelRequest(id: Int, handler: @escaping (OfferCancelResponse?) -> Void){
        Session.send(API.OfferCancelRequest(id: id)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: offerCancelRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
}


// MARK: - api for Request
extension API {
    
    /** return RequestGetResponse
     *   API.requestCreateRequest(offerId: 2, price: 3000, comment: "この値段で切れますよ！") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func requestGetRequest(handler: @escaping (RequestGetResponse?) -> Void){
        Session.send(API.RequestGetRequest()) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: requestGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return RequestDetailGetResponse
     *   API.requestDetailGetRequest(id: 1) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func requestDetailGetRequest(id: Int, handler: @escaping (RequestDetailGetResponse?) -> Void){
        Session.send(API.RequestDetailGetRequest(id: id)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: requestDetailGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return RequestTakeResponse
     *   API.requestTakeRequest(id: 1) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func requestTakeRequest(id: Int, handler: @escaping (RequestTakeResponse?) -> Void){
        Session.send(API.RequestTakeRequest(id: id)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: requestTakeRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
}

// MARK: - api for Stylist
extension API {
    
    /** return RequestCreateResponse
     *   API.requestCreateRequest(offerId: 2, price: 3000, comment: "この値段で切れますよ！") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func requestCreateRequest(offerId: Int, price: Float, comment: String?, handler: @escaping (RequestCreateResponse?) -> Void){
        Session.send(API.RequestCreateRequest(offerId: offerId, price: price, comment: comment)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: offerGetDetailRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return ReservationListGetResponse
     *   API.reservationListGetRequest() { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func reservationListGetRequest(handler: @escaping (ReservationListGetResponse?) -> Void){
        Session.send(API.ReservationListGetRequest()) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: reservationListGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
}

// MARK: - api for Review
extension API {
    
    /** return ReviewCreateResponse
     *   API.reviewCreateRequest(dealUserId: 1, star: 4, comment: "すごく良かったです！") { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func reviewCreateRequest(dealUserId:Int, star:Int, comment:String?, handler: @escaping (ReviewCreateResponse?) -> Void){
        Session.send(API.ReviewCreateRequest(dealUserId: dealUserId, star: star, comment: comment)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: reviewCreateRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return OwnReviewGetResponse
     *   API.ownReviewGetRequest() { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func ownReviewGetRequest(handler: @escaping (OwnReviewGetResponse?) -> Void){
        Session.send(API.OwnReviewGetRequest(id: nil)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: ownReviewGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
    /** return OwnReviewGetResponse
     *   API.reviewGetRequest(id: 1) { (result) in
     *      if let res = result { print("result: \(res)") }
     *   }
     */
    class func reviewGetRequest(id:Int?, handler: @escaping (OwnReviewGetResponse?) -> Void){
        Session.send(API.OwnReviewGetRequest(id: id)) { result in
            switch result {
            case .success(let response):
                handler(response)
            case .failure(let error):
                print("Error: reviewGetRequest -> \(error)")
                handler(nil)
            }
        }
    }
    
}

/// DecodableDataParser
final class DecodableDataParser: DataParser {
    
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
    
}
