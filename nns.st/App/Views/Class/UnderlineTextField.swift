//
//  UnderlineTextField.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/12.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class UnderlineTextField: UITextField {
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 5, 0, 5))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 5, 0, 5))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 5, 0, 5))
    }
    
    @IBInspectable var height: CGFloat = 1 {
        didSet {
            self.setUnderLine()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.setUnderLine()
        }
    }
    
    @IBInspectable var placeholderTextColor: UIColor = UIColor.white {
        didSet {
            self.setUnderLine()
        }
    }
    
    @IBInspectable var placeholderText: String = "" {
        didSet {
            self.setUnderLine()
        }
    }
    
    @IBInspectable var placeholderImage: UIImage = UIImage() {
        didSet {
            self.setUnderLine()
        }
    }
    
    @IBInspectable var phImgWidth: CGFloat = 10 {
        didSet {
            self.setUnderLine()
        }
    }
    
    @IBInspectable var phImgHeight: CGFloat = 10 {
        didSet {
            self.setUnderLine()
        }
    }
    
    private func setUnderLine() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - self.height,
                              width: self.frame.width, height: height)
        border.backgroundColor = borderColor.cgColor
        
        let textAttachment = NSTextAttachment(data: nil, ofType: nil)
        textAttachment.image = placeholderImage.reSizeImage(reSize: CGSize(width: phImgWidth, height: phImgHeight))
        
        let attributeString = NSAttributedString(attachment: textAttachment)
        let attributedTxt = NSMutableAttributedString(attributedString: attributeString)
        let placeholderTxt = NSAttributedString(string: placeholderText, attributes: [NSAttributedStringKey.foregroundColor : placeholderTextColor])
        attributedTxt.append(placeholderTxt)
        
        self.attributedPlaceholder = attributedTxt
        self.layer.addSublayer(border)
    }

}
