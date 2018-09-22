//
//  NNSCore.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/31.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

enum NNSDataKey: String {
    case authToken = "AuthToken"
    case isWaitState = "WaitState"
    case isMadeOfferId = "MadeOfferId"
    case dealUserId = "dealUserId"
}

// MARK: - Token
class NNSCore {
    class func authToken() -> String? {
        return UserDefaults.standard.string(forKey: NNSDataKey.authToken.rawValue)
    }
    
    class func setAuthToken(_ token: String?) {
        if token == nil {return}
        UserDefaults.standard.set(token!, forKey: NNSDataKey.authToken.rawValue)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - WaitState
extension NNSCore {
    
    class func isWaitState() -> Bool {
        return UserDefaults.standard.bool(forKey: NNSDataKey.isWaitState.rawValue)
    }
    
    class func setWaitState(_ isWait: Bool) {
        UserDefaults.standard.set(isWait, forKey: NNSDataKey.isWaitState.rawValue)
        UserDefaults.standard.synchronize()
    }
    
}

// MARK: - MadeOfferState
extension NNSCore {
    
    class func madeOfferId() -> Int {
        return UserDefaults.standard.integer(forKey: NNSDataKey.isMadeOfferId.rawValue)
    }
    
    class func setMadeOfferId(_ id: Int) {
        UserDefaults.standard.set(id, forKey: NNSDataKey.isMadeOfferId.rawValue)
        UserDefaults.standard.synchronize()
    }
    
}

// MARK: - dealUserId
extension NNSCore {
    
    class func dealUserId() -> Int {
        return UserDefaults.standard.integer(forKey: NNSDataKey.dealUserId.rawValue)
    }
    
    class func setDealUserId(_ id: Int) {
        UserDefaults.standard.set(id, forKey: NNSDataKey.dealUserId.rawValue)
        UserDefaults.standard.synchronize()
    }
    
}
