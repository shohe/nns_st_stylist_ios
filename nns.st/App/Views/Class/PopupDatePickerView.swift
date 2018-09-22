//
//  PopupDatePickerView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/19.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

protocol PopupDatePickerViewDelegate {
    func popupDatePicker(_pickerView: PopupDatePickerView, didCanceled sender: UIButton)
    func popupDatePicker(_pickerView: PopupDatePickerView, didSelected sender: UIButton)
}

class PopupDatePickerView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    
    var delegate: PopupDatePickerViewDelegate?
    
    private let show: CGFloat = 32
    private let hide: CGFloat = -480
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        let contentView = Bundle.main.loadNibNamed("PopupDatePickerView", owner: self, options: nil)?.first as! UIView
        contentView.frame = self.bounds
        self.alpha = 0
        addSubview(contentView)
    }

    @IBAction func cancel(_ sender: UIButton) {
        delegate?.popupDatePicker(_pickerView: self, didCanceled: sender)
    }

    @IBAction func selected(_ sender: UIButton) {
        delegate?.popupDatePicker(_pickerView: self, didSelected: sender)
    }
}

extension PopupDatePickerView {
    
    func initPopupDatePicker() {
        UIView.animate(withDuration: 0.3) {
            self.bottomConst.constant = self.show
            self.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
    func hidePopupDatePicker() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomConst.constant = self.hide
            self.alpha = 0
            self.layoutIfNeeded()
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
        
    }
    
}
