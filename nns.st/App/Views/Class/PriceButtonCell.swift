//
//  PriceButtonCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

protocol PriceButtonCellDelegate {
    func priceButtonCell(_ didSelectedButton: PriceButton)
}

class PriceButtonCell: UITableViewCell {
    
    var delegate: PriceButtonCellDelegate? = nil
    
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    static var identifier:String {
        get{
            return "PriceButtonCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "PriceButtonCell", bundle: nil)
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


// MARK: - public
extension PriceButtonCell {
    
    func setPrice(price: Float, currency: CurrencyType) {
        self.priceLabel.text = PriceLabelMaker.addCarrency(price: price, currency: .JPY, isHiddenSymbol: true)
    }
    
}


// MARK: - IBAction
extension PriceButtonCell {
    
    @IBAction func makeReservation(_ sender: PriceButton) {
        self.delegate?.priceButtonCell(sender)
    }
    
}
