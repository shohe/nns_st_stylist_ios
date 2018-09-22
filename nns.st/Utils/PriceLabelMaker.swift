//
//  PriceLabelMaker.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation

class PriceLabelMaker {
    
    static func addCarrency(price: Float, currency: CurrencyType, isHiddenSymbol: Bool) -> String {
        let num = NSNumber(value: price)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        var priceText = formatter.string(from: num)
        if let pt = priceText {
            priceText = isHiddenSymbol ? ("\(currency.rawValue)\(pt)") : ("\(currency.rawValue)\(pt) \(currency.symbol())")
            return (priceText != nil) ? priceText! : "\(price)"
        } else {
            return "\(price)"
        }
    }
    
}
