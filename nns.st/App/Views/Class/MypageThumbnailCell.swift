//
//  MypageThumbnailCell.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/24.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

protocol MypageThumbnailCellDelegate {
    func myThumbnailCell(_ cell: MypageThumbnailCell, didTapPicture thumbnail: UIImageView)
}

class MypageThumbnailCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    
    var delegate: MypageThumbnailCellDelegate?
    
    static var identifier:String {
        get{
            return "MypageThumbnailCell"
        }
    }
    
    static var nib:UINib {
        get{
            return UINib(nibName: "MypageThumbnailCell", bundle: nil)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addThumbnailGesture(view: thumbnailView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


// MARK: - IBAction
extension MypageThumbnailCell {
    
    @IBAction func changePicture(_ sender: Any) {
        delegate?.myThumbnailCell(self, didTapPicture: self.thumbnailView)
    }
    
}


// MARK: - private function
extension MypageThumbnailCell {
    
    private func addThumbnailGesture(view: UIImageView) {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePicture(_:))))
    }
    
}

