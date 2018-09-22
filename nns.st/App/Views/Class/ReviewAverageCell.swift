//
//  ReviewAverageCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/30.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ReviewAverageCell: UITableViewCell {
    
    @IBOutlet weak var totalAveraveLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var fiveStarProgress: UIProgressView!
    @IBOutlet weak var fourStarProgress: UIProgressView!
    @IBOutlet weak var threeStarProgress: UIProgressView!
    @IBOutlet weak var twoStarProgress: UIProgressView!
    @IBOutlet weak var oneStarProgress: UIProgressView!
    @IBOutlet weak var fiveStarView: StarView!
    @IBOutlet weak var fourStarView: StarView!
    @IBOutlet weak var threeStarView: StarView!
    @IBOutlet weak var twoStarView: StarView!
    @IBOutlet weak var oneStarView: StarView!
    
    static var identifier:String {
        get{
            return "ReviewAverageCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "ReviewAverageCell", bundle: nil)
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


extension ReviewAverageCell {
    
    func setItem(item: EvaluateItem) {
        self.initStars()
        self.totalAveraveLabel.text = "\(item.average)"
        self.sumLabel.text = "\(self.getCountOfReviews(item: item))件のレビュー"
        self.setProgress(item: item)
    }
    
    private func initStars() {
        let starViews: [StarView] = [oneStarView, twoStarView, threeStarView, fourStarView, fiveStarView]
        for i in 0...4 {
            starViews[i].setStar(number: -(i+1)) // "-" -> for revers star order
        }
    }
    
    private func getCountOfReviews(item: EvaluateItem) -> Int {
        let total = item.one + item.two + item.three + item.four + item.five
        return total
    }
    
    private func setProgress(item: EvaluateItem) {
        let total = self.getCountOfReviews(item: item)
        if total > 0 {
            self.oneStarProgress.progress = Float(item.one) / Float(total)
            self.twoStarProgress.progress = Float(item.two) / Float(total)
            self.threeStarProgress.progress = Float(item.three) / Float(total)
            self.fourStarProgress.progress = Float(item.four) / Float(total)
            self.fiveStarProgress.progress = Float(item.five) / Float(total)
        } else {
            self.oneStarProgress.progress = 0
            self.twoStarProgress.progress = 0
            self.threeStarProgress.progress = 0
            self.fourStarProgress.progress = 0
            self.fiveStarProgress.progress = 0
        }
    }
    
}
