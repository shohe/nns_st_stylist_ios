//
//  DistanceInfoCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/20.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class DistanceInfoCell: UITableViewCell {
    
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    static var identifier:String {
        get{
            return "DistanceInfoCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "DistanceInfoCell", bundle: nil)
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


extension DistanceInfoCell {
    
    func setEachValue(item: OfferItem?) {
        if let item = item {
            placeTitle.text = item.place
            if let distance = item.distance {
                distanceLabel.text = "\(distance)km"
            }
        }
    }
    
}
