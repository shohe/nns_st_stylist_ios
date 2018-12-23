//
//  TakeOfferViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/23.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

protocol TakeOfferViewControllerDelegate {
    func takeOfferView(_ didTakeOffer: Bool, offerId: Int)
}

class TakeOfferViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var finalPrice: UITextField! {
        didSet {
            finalPrice?.addDoneToolbar(onDone: (target: self, action: #selector(donePrice)))
        }
    }
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var reviewPlaceholder: UILabel!
    
    private var item: OfferGetDetailItem!
    private var requestPrice: Float = 0.0
    private var loadingView: LoadingView?
    
    private var delegate: TakeOfferViewControllerDelegate?
    
    static func instantiateViewController(item: OfferGetDetailItem, parent: MainViewController?) -> UIViewController {
        let storyboard = UIStoryboard(name: "Confirm", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TakeOfferViewController") as! TakeOfferViewController
        viewController.item = item
        viewController.delegate = parent
        return viewController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBorder()
        self.setPrace()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(StylistProfileWithStarCell.nib, forCellReuseIdentifier: StylistProfileWithStarCell.identifier)
    }
    
}


// MARK: private
extension TakeOfferViewController {
    
    private func setBorder() {
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setPrace() {
        requestPrice = item.price
        finalPrice.text = makePrice(price: item.price)
    }
    
    private func makePrice(price: Float) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedPrice = numberFormatter.string(from: NSNumber(value: price))
        if let price = formattedPrice {
            return "¥\(price)"
        }
        return ""
    }
    
    private func priceToNumber(text: String?) -> String? {
        if var price = (text as NSString?) {
            price = price.replacingOccurrences(of: "¥", with: "") as NSString
            price = price.replacingOccurrences(of: ",", with: "") as NSString
            if price != "0" {
                return String(price)
            }
        }
        return nil
    }
    
    private func textToPrice(text: String?) -> String {
        if let price = (text as NSString?)?.floatValue {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedPrice = numberFormatter.string(from: NSNumber(value: price))
            if let price = formattedPrice {
                return "¥\(price)"
            }
        }
        return ""
    }
    
    private func errorAlert() {
        let title = "金額エラー"
        let message = "オファーされた金額以上の価格に設定することはできません。"
        let okText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okayButton)
        
        present(alert, animated: true, completion: nil)
    }
    
}


// MARK: IBAction
extension TakeOfferViewController {
    
    @IBAction func touchScreen(_ sender: UITapGestureRecognizer) {
        self.finalPrice.resignFirstResponder()
        self.commentTextView.resignFirstResponder()
    }
    
    @IBAction func pushRequestButton(_ sender: UIButton) {
        loadingView = LoadingView(frame: self.view.bounds)
        self.view.addSubview(loadingView!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView!.alpha = 1
        }) { (complete) in
            /* send this offer to server */
            API.requestCreateRequest(offerId: self.item.id, price: self.requestPrice, comment: self.commentTextView.text, handler: { (result) in
                if result != nil {
                    self.delegate?.takeOfferView(true, offerId: self.item.id)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
        
    }
    
}


// MARK: - UITextFieldDelegate
extension TakeOfferViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1 /* finalPrice */ {
            textField.text = priceToNumber(text: textField.text)
        }
        return true
    }
    
    @objc func donePrice() {
        if let price = (finalPrice.text as NSString?)?.floatValue {
            if price > item.price {
                errorAlert()
            } else {
                requestPrice = Float(price)
                finalPrice.text = textToPrice(text: finalPrice.text)
                finalPrice.resignFirstResponder()
            }
        }
    }
    
}


extension TakeOfferViewController : UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        reviewPlaceholder.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            reviewPlaceholder.isHidden = false
        }
    }
    
}


// MARK: - UITableViewDelegate
extension TakeOfferViewController : UITableViewDelegate {
    
}


// MARK: - UITableViewDataSource
extension TakeOfferViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: StylistProfileWithStarCell.identifier, for: indexPath) as? StylistProfileWithStarCell {
            cell.setItem(item: self.item)
            return cell
        }
        
        return UITableViewCell()
    }

}
