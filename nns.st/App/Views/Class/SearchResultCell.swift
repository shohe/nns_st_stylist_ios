//
//  SearchResultCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/18.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var placemark: MKPlacemark!
    
    static var identifier:String {
        get{
            return "SearchResultCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "SearchResultCell", bundle: nil)
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
