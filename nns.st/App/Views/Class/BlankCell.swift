//
//  BlankCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/17.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class BlankCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    static var identifier:String {
        get{
            return "BlankCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "BlankCell", bundle: nil)
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
