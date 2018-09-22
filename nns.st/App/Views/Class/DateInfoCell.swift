//
//  DateInfoCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/20.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class DateInfoCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    static var identifier:String {
        get{
            return "DateInfoCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "DateInfoCell", bundle: nil)
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


extension DateInfoCell {
    
    func setItem(item: OfferGetDetailItem?) {
        if let i = item {
            dateLabel.text = self.fixFormat(isoDate: i.dateTime)
        }
    }
    
    func setItem(item: OfferHistoryDetailGetItem?) {
        if let i = item {
            dateLabel.text = self.fixFormat(isoDate: i.dateTime)
        }
    }
    
    func setEachValue(item: OfferItem?) {
        if let item = item {
            setDateTime(date: item.datetime)
        }
    }
    
    private func fixFormat(isoDate: String) -> String {
        let dateArray = isoDate.components(separatedBy: " ")
        let timeArray = dateArray[1].components(separatedBy: ":")
        let fixed = "\(dateArray[0])  \(timeArray[0]) : \(timeArray[1]) ~"
        return fixed
    }
    
    private func setDateTime(date: Date?) {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd  HH : mm ~"
            dateLabel.text = dateFormatter.string(from: date)
        }
    }
    
}
