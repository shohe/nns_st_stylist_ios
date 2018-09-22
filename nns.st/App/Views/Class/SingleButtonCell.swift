//
//  SingleButtonCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit


protocol SingleButtonCellDelegate {
    func singleButtonCell(_ didSelectedButton: PriceButton)
}

class SingleButtonCell: UITableViewCell {
    
    var delegate: SingleButtonCellDelegate? = nil
    
    
    static var identifier:String {
        get{
            return "SingleButtonCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "SingleButtonCell", bundle: nil)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


// MARK: - IBAction
extension SingleButtonCell {
    
    @IBAction func canselOffer(_ sender: PriceButton) {
        self.delegate?.singleButtonCell(sender)
    }
    
}
