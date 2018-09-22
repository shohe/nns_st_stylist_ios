//
//  UIImage+reSizeImage.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/12.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

extension UIImage {
    
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage! = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
}
