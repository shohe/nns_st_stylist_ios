//
//  ContainButtonTextField.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/12.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ContainButtonTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 20, 0, 15))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 20, 0, 15))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 20, 0, 54))
    }
    
    
    @IBInspectable var btnColor: UIColor = UIColor.white {
        didSet {
            self.setUp()
        }
    }
    
    @IBInspectable var phTextColor: UIColor = UIColor.white {
        didSet {
            self.setUp()
        }
    }
    
    @IBInspectable var phText: String = "" {
        didSet {
            self.setUp()
        }
    }
    
}


extension ContainButtonTextField {
    
    private func setUp() {
        self.attributedPlaceholder = NSAttributedString(string: phText, attributes: [NSAttributedStringKey.foregroundColor : phTextColor])
        self.layer.masksToBounds = true
    }
    
}
