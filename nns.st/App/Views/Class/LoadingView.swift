//
//  LoadingView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/21.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    @IBOutlet weak var commentLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

}


extension LoadingView {
    
    private func initView() {
        let contentView = Bundle.main.loadNibNamed("LoadingView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        self.alpha = 0
        addSubview(contentView)
    }
    
    func setComment(text: String?) {
        commentLabel.text = text
    }
    
}
