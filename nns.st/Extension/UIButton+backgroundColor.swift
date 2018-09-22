//
//  UIButton+backgroundColor.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/16.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
        let image = color.image
        setBackgroundImage(image, for: state)
    }
    
}
