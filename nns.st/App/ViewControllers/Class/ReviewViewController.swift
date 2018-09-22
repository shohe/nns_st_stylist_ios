//
//  ReviewViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/21.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var star01: UIButton!
    @IBOutlet weak var star02: UIButton!
    @IBOutlet weak var star03: UIButton!
    @IBOutlet weak var star04: UIButton!
    @IBOutlet weak var star05: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var placeholder: UILabel!
    
    private var stars: [UIButton] = []
    private var loadingView: LoadingView?
    private var star = 0
    
    static func instantiateViewController() -> ReviewViewController {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ReviewViewController
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stars = [star01, star02, star03, star04, star05]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ReviewViewController {
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        textView.resignFirstResponder()
    }
    
    @IBAction func didTapStar(_ sender: UIButton) {
        updateSendButton(isEnable: true)
        evaluateStar(sender: sender)
    }
    
    @IBAction func sendReview(_ sender: UIButton) {
        textView.resignFirstResponder()
        
        loadingView = LoadingView(frame: self.view.bounds)
        loadingView?.setComment(text: "レビュー送信中...")
        self.view.addSubview(loadingView!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView!.alpha = 1
        }) { (complete) in
            /* send this review to server */
            // here is just sample. remove after all.
            API.reviewCreateRequest(dealUserId: NNSCore.dealUserId(), star: self.star, comment: self.textView.text, handler: { (result) in
                if result == nil { print("create review error.") }
                NNSCore.setDealUserId(0)
                NNSCore.setWaitState(false)
                NNSCore.setMadeOfferId(0)
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    private func evaluateStar(sender: UIButton) {
        for star in stars {
            star.setBackgroundImage(UIImage(named: "blankStar"), for: .normal)
        }
        for evaluate in 1...sender.tag {
            stars[evaluate - 1].setBackgroundImage(UIImage(named: "star"), for: .normal)
            self.star = sender.tag
        }
    }
    
    private func updateSendButton(isEnable: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.sendButton.alpha = (isEnable) ? 1 : 0.3
        }) { (complete) in
            self.sendButton.isEnabled = isEnable
        }
    }
    
    private func updatePlaceholder(isShown: Bool) {
        placeholder.alpha = (isShown) ? 1 : 0
    }
    
}


extension ReviewViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        updatePlaceholder(isShown: false)
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text == "" {
            updatePlaceholder(isShown: true)
        }
        return true
    }
    
}
