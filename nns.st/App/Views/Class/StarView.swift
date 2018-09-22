//
//  StarView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/30.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

@IBDesignable
class StarView: UIView {
    
    
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    
    @IBInspectable var resource: UIImage? = UIImage() {
        didSet {
            self.initStars()
        }
    }
    
    @IBInspectable var emptyResouce: UIImage? = UIImage() {
        didSet {
            self.initStars()
        }
    }
    
    
    //* plus number express from left side (default) *//
    //* minus number express from right side *//
    //* ex)           ★★★★★
    //* -----------------------
    //* ex) 2 ->     ★★ - - -
    //* ex) 12 ->     ★★☆☆☆
    //* ex) -3 ->    - - ★★★
    //* ex) -13 ->    ☆☆★★★
    var count: Int = 0
    
    private var stars: [UIImageView] = []
    
    
    //* height:width = 1:5.5 is the best rate *//
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func setStar(number: Int) {
        self.count = number
        self.initCount()
    }

}


// MARK: - private
extension StarView {
    
    private func initView() {
        let contentView = Bundle.main.loadNibNamed("StarView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        self.stars = [firstStar, secondStar, thirdStar, fourthStar, fifthStar]
        addSubview(contentView)
    }
    
    private func initStars() {
        for star in stars {
            star.image = resource
            star.highlightedImage = emptyResouce
        }
    }
    
    private func initCount() {
        if self.count > 0 { //* count from left side *//
            for i in 0..<5 {
                colorChange(_count: self.count, roop: i, isReversed: false)
            }
        } else { //* count from right side *//
            self.count *= -1
            for i in 0..<5 {
                colorChange(_count: self.count, roop: i, isReversed: true)
            }
        }
    }
    
    private func colorChange(_count: Int, roop: Int, isReversed: Bool) {
        let count = (_count >= 10) ? _count - 10 : _count
        let isHighlighted = (_count >= 10) ? true : false
        
        if isReversed {
            let cnt = 5 - count
            if isHighlighted {
                self.stars[roop].isHighlighted = (roop < cnt) ? true : false
            } else {
                self.stars[roop].isHidden = (roop < cnt) ? true : false
            }
        } else {
            if isHighlighted {
                self.stars[roop].isHighlighted = (roop < count) ? false : true
            } else {
                self.stars[roop].isHidden = (roop < count) ? false : true
            }
        }
    }
    
}
