//
//  BackgroundView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/12.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {

    var gradientLayer: CAGradientLayer?
    
    @IBInspectable var topColor: UIColor = UIColor.white {
        didSet {
            self.setGradation()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.black {
        didSet {
            self.setGradation()
        }
    }
    
    private func setGradation() {
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = CAGradientLayer()
        gradientLayer!.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer!.frame = self.bounds
        layer.insertSublayer(gradientLayer!, at: 0)
        layer.masksToBounds = true
    }
    
}
