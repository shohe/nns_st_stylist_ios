//
//  MypageStatusCommentCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/24.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MypageStatusCommentCell: UITableViewCell {
    
    @IBOutlet weak var statusComment: UITextField!
    
    static var identifier:String {
        get{
            return "MypageStatusCommentCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "MypageStatusCommentCell", bundle: nil)
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
