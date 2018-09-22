//
//  ReviewCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/16.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerHeightConst: NSLayoutConstraint!
    @IBOutlet weak var headerBottomConst: NSLayoutConstraint!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var starView: StarView!
    
    static var identifier:String {
        get{
            return "ReviewCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "ReviewCell", bundle: nil)
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


// MARK: -
extension ReviewCell {
    
    func nonTitle() -> Void {
        headerTitle.isHidden = true
        headerHeightConst.constant = 0
        headerBottomConst.constant = 0
    }
    
    func setItem(item: OwnReviewGetItem) {
        self.userName.text = item.writerName
        self.comment.text = item.comment
        self.starView.setStar(number: item.star + 10) // +10 -> show blank star
        if let date = item.dateTime?.split(separator: " ").first {
            self.date.text = String(date)
        }
    }
    
}
