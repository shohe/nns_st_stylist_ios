//
//  HistoryCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/21.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static var identifier:String {
        get{
            return "HistoryCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "HistoryCell", bundle: nil)
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


extension HistoryCell {
    
    func setItem(item: OfferHistoryListGetItem) {
        let date = item.dateTime.split(separator: " ")[0]
        dateLabel.text = String(date)
        nameLabel.text = item.name
        menuLabel.text = item.menu
        priceLabel.text = PriceLabelMaker.addCarrency(price: item.price, currency: .JPY, isHiddenSymbol: false)
        if let url = item.imageUrl { userImageView.loadImage(urlString: url) }
    }
    
}
