//
//  CharityDetailViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/23.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class CharityDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    static func instantiateViewController() -> CharityDetailViewController {
        let storyboard = UIStoryboard(name: "Charity", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CharityDetailViewController") as! CharityDetailViewController
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadWeb(url: "https://www.google.com")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - private function
extension CharityDetailViewController {
    
    private func loadWeb(url: String) {
        if let url: URL = URL(string: url) {
            let req = NSURLRequest(url: url)
            webView.loadRequest(req as URLRequest)
        }
    }
    
}


// MARK: - UIWebViewDelegate
extension CharityDetailViewController: UIWebViewDelegate {
    
    
    
}
