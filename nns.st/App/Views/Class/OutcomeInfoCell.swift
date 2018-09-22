//
//  OutcomeInfoCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/20.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class OutcomeInfoCell: UITableViewCell {
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var charityPriceLabel: UILabel!
    @IBOutlet weak var serviceFeeLabel: UILabel!
    
    let charityRate: CGFloat = 0.05
    let serviceFeeRate: CGFloat = 0.1
    
    static var identifier:String {
        get{
            return "OutcomeInfoCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "OutcomeInfoCell", bundle: nil)
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


extension OutcomeInfoCell {
    
    func setItem(item: OfferGetDetailItem?) {
        if let i = item {
            self.menuLabel.text = i.menu
            self.priceLabel.text = self.makePriceLabel(price: CGFloat(i.price))
            self.charityPriceLabel.text = self.makePriceLabel(price: CGFloat(i.price)*charityRate)
            self.serviceFeeLabel.text = self.makePriceLabel(price: CGFloat(i.price)*serviceFeeRate)
        }
    }
    
    func setItem(item: OfferHistoryDetailGetItem?) {
        if let i = item {
            self.menuLabel.text = i.menu
            self.priceLabel.text = self.makePriceLabel(price: CGFloat(i.price))
            self.charityPriceLabel.text = self.makePriceLabel(price: CGFloat(i.price)*charityRate)
            self.serviceFeeLabel.text = self.makePriceLabel(price: CGFloat(i.price)*serviceFeeRate)
        }
    }
    
    func setEachValue(item: OfferItem?) {
        if let item = item {
            menuLabel.text = item.menu
            setPrice(price: item.price)
        }
    }
    
    private func setPrice(price: CGFloat?) {
        if let price = price {
            priceLabel.text = makePriceLabel(price: price)
            self.charityPriceLabel.text = self.makePriceLabel(price: price*charityRate)
            self.serviceFeeLabel.text = self.makePriceLabel(price: price*serviceFeeRate)
        }
    }
    
    private func makePriceLabel(price: CGFloat) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedPrice = numberFormatter.string(from: NSNumber(value: Float(price)))
        if let price = formattedPrice {
            return "¥\(price)JPY"
        }
        return "¥0JPY"
    }
    
}
