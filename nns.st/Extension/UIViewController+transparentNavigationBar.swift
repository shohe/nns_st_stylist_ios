//
//  UIViewController+transparentNavigationBar.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/12.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // use in viewWillAppear(_ animated: Bool)
    func transparentNavigationBar() {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    // use in viewWillDisappear(_ animated: Bool)
    func cancelTransparentNavigationBar() {
        self.navigationController!.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController!.navigationBar.shadowImage = nil
    }
    
}
