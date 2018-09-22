//
//  CurrencyType.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/09.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

enum CurrencyType: String {
    case JPY = "¥"
    case USD, CAD = "$"
    
    func symbol() -> String {
        switch self {
            case .JPY: return "JPY"
            case .USD: return "USD"
            case .CAD: return "CAD"
        }
    }
}
