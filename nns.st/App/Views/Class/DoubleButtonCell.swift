//
//  DoubleButtonCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/22.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

protocol DoubleButtonCellDelegate {
    func doubleButtonCell(_didSelectedOfferButton: DoubleButtonCell)
    func doubleButtonCell(_didSelectedProfileButton: DoubleButtonCell)
}

class DoubleButtonCell: UITableViewCell {
    
    @IBOutlet weak var rightButtonLabel: UILabel!
    
    static var identifier:String {
        get{
            return "DoubleButtonCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "DoubleButtonCell", bundle: nil)
        }
    }
    
    var delegate: DoubleButtonCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: -
extension DoubleButtonCell {
    
    func receiveMode() {
        rightButtonLabel.text = "オファーを受ける"
    }
    
}


// MARK: - IBAction
extension DoubleButtonCell {
    
    @IBAction func goOfferPage(_ sender: PriceButton) {
        self.delegate?.doubleButtonCell(_didSelectedOfferButton: self)
    }
    
    @IBAction func goProfilePage(_ sender: PriceButton) {
        self.delegate?.doubleButtonCell(_didSelectedProfileButton: self)
    }
    
}
