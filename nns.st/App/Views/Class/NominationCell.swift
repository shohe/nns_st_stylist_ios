//
//  NominationCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/22.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class NominationCell: UITableViewCell {
    
    @IBOutlet weak var stylistImage: UIImageView!
    @IBOutlet weak var stylistName: UILabel!
    @IBOutlet weak var salonName: UILabel!
    
    static var identifier:String {
        get{
            return "NominationCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "NominationCell", bundle: nil)
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


extension NominationCell {
    
    func setEachValue(item: User) {
        self.stylistName.text = item.name
        self.salonName.text = item.salonName
        if let url = item.imageUrl { self.stylistImage.loadImage(urlString: url) }
    }
    
}
