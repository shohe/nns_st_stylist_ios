//
//  CommentCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/16.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var comment: UILabel!
    
    static var identifier:String {
        get{
            return "CommentCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "CommentCell", bundle: nil)
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


extension CommentCell {
    
    func setItem(item: OfferGetDetailItem?) {
        if let i = item {
            comment.text = i.comment
        }
    }
    
    func setItem(item: OfferHistoryDetailGetItem?) {
        if let i = item {
            comment.text = i.comment
        }
    }
    
}
