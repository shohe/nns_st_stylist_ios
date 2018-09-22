//
//  StylistProfileWithStarCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class StylistProfileWithStarCell: UITableViewCell {
    
    static var identifier:String {
        get{
            return "StylistProfileWithStarCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "StylistProfileWithStarCell", bundle: nil)
        }
    }

    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var statusComment: UILabel!
    @IBOutlet weak var starView: StarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension StylistProfileWithStarCell {
    
    func setItem(item: OfferGetDetailItem?) {
        if let i = item {
            if let url = i.cxImageUrl { self.thumbnailView.loadImage(urlString: url) }
            self.statusComment.text = i.cxStatusComment
            if let star = i.cxStar {
                self.starView.setStar(number: star + 10) // +10 for show blank star
            } else {
                self.starView.setStar(number: 10)
            }
        }
    }
    
    func setItem(item: OfferHistoryDetailGetItem?, star: Int?) {
        if let i = item {
            if let url = i.imageUrl { self.thumbnailView.loadImage(urlString: url) }
            self.statusComment.text = i.statusComment
            if let _star = star {
                self.starView.setStar(number: _star + 10) // +10 for show blank star
            } else {
                self.starView.setStar(number: 10)
            }
        }
    }
    
    func setItem(item: OwnReviewGetResponse?) {
        if let i = item {
            if let url = i.user.imageUrl { self.thumbnailView.loadImage(urlString: url) }
            self.statusComment.text = i.user.statusComment
            self.starView.setStar(number: Int(round(i.evaluate.average)) + 10) // +10 for show blank star
        }
    }
    
    func setItem(item: UserItem?, star: Int?) {
        if let i = item {
            if let url = i.imageUrl { self.thumbnailView.loadImage(urlString: url) }
            self.statusComment.text = i.statusComment
            if let _star = star {
                self.starView.setStar(number: _star + 10) // +10 for show blank star
            } else {
                self.starView.setStar(number: 10)
            }
        }
    }
    
    
}
