//
//  HairType.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/20.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import Foundation
import UIKit

enum HairType: Int {
    
    case veryShort = 1
    case short = 2
    case midium = 3
    case long = 4
    case veryLong = 5
    
    func title() -> String {
        switch self {
        case .veryShort:
            return "veryShort"
        case .short:
            return "short"
        case .midium:
            return "midium"
        case .long:
            return "long"
        case .veryLong:
            return "veryLong"
        }
    }
    
    func image() -> UIImage {
        switch self {
        case .veryShort:
            return UIImage()
        case .short:
            return UIImage()
        case .midium:
            return UIImage()
        case .long:
            return UIImage()
        case .veryLong:
            return UIImage()
        }
    }
    
}
