//
//  ConfirmOfferViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/20.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

protocol ConfirmOfferViewControllerDelegate {
    func confirmOfferViewController(_ didCreateOffer: Offer)
}

class ConfirmOfferViewController: UIViewController {
    
    var offerItem: OfferItem?
    var loadingView: LoadingView?
    var delegate: ConfirmOfferViewControllerDelegate?
    
    private var stylist: User!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentTextView: UITextView!
    
    
    static func instantiateViewController(parent: MainViewController) -> ConfirmOfferViewController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConfirmOfferViewController") as! ConfirmOfferViewController
        viewController.delegate = parent
        return viewController
    }
    
    static func instantiateViewController(parent: MainViewController, stylist: User) -> ConfirmOfferViewController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConfirmOfferViewController") as! ConfirmOfferViewController
        viewController.delegate = parent
        viewController.stylist = stylist
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureObserver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(OutcomeInfoCell.nib, forCellReuseIdentifier: OutcomeInfoCell.identifier)
        tableView.register(DateInfoCell.nib, forCellReuseIdentifier: DateInfoCell.identifier)
        tableView.register(DistanceInfoCell.nib, forCellReuseIdentifier: DistanceInfoCell.identifier)
        tableView.register(NominationCell.nib, forCellReuseIdentifier: NominationCell.identifier)
        tableView.register(HairTypeInfoCell.nib, forCellReuseIdentifier: HairTypeInfoCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver()
    }

}


// MARK: - UITableViewDataSource
extension ConfirmOfferViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OutcomeInfoCell.identifier, for: indexPath) as? OutcomeInfoCell {
                cell.setEachValue(item: offerItem)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DateInfoCell.identifier, for: indexPath) as? DateInfoCell {
                cell.setEachValue(item: offerItem)
                return cell
            }
        case 2:
            if offerItem?.stylistId == nil {
                if let cell = tableView.dequeueReusableCell(withIdentifier: DistanceInfoCell.identifier, for: indexPath) as? DistanceInfoCell {
                    cell.setEachValue(item: offerItem)
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: NominationCell.identifier, for: indexPath) as? NominationCell {
                    cell.setEachValue(item: self.stylist)
                    return cell
                }
            }
            
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HairTypeInfoCell.identifier, for: indexPath) as? HairTypeInfoCell {
                cell.setEachValue(item: offerItem)
                return cell
            }
       default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
}


// MARK: - UITableViewDelegate
extension ConfirmOfferViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let space: CGFloat = 235.0
            
            var frame: CGRect = tableView.frame
            frame.size.height = tableView.contentSize.height
            tableView.frame = frame
            
            commentTextViewHeight.constant = self.view.frame.height - tableView.frame.height - space - (self.navigationController?.navigationBar.frame.height)!
        }
    }
    
}


// MARK: - private function
extension ConfirmOfferViewController {
    
    private func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification?) {
        if let userInfo = notification?.userInfo {
            if let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue, let _ = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
                
                self.view.transform = CGAffineTransform.identity
                let convertedKeyboardFrame = self.view.convert(keyboardFrame, from: nil)
                
                let space: CGFloat = 118.0
                let height: CGFloat = self.view.frame.height - space
                let offsetY: CGFloat = height - convertedKeyboardFrame.minY
                if offsetY < 0 { return }

                self.view.transform = CGAffineTransform(translationX: 0, y: -offsetY)
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        })
    }
    
    private func createOffer() -> Offer? {
        if let item = self.offerItem {
            if let menu = item.menu, let price = item.price, let dateTime = castDateToString(date: item.datetime), let hairType = item.hairType {
                
                var offer = Offer(menu: menu, price: Float(price), dateTime: dateTime, hairType: hairType)
                offer.comment = self.commentTextView.text
                
                if let stylistId = item.stylistId {
                    offer.stylistId = stylistId
                    return offer
                } else {
                    if let range = item.distance, let location = item.location {
                        offer.distanceRange = Float(range)
                        offer.fromLocationLat = location.latitude
                        offer.fromLocationLng = location.longitude
                        return offer
                    }
                }
            }
        }
        return nil
    }
    
    private func castDateToString(date: Date?) -> String? {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
}


// MARK: - IBAction
extension ConfirmOfferViewController {
    
    @IBAction func didtapView(_ sender: UITapGestureRecognizer) {
        commentTextView.resignFirstResponder()
    }
    
    @IBAction func makeOffer(_ sender: UIButton) {
        loadingView = LoadingView(frame: self.view.bounds)
        self.view.addSubview(loadingView!)
        
        if let offer = self.createOffer() {
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingView!.alpha = 1
            }) { (complete) in
                /* send this offer to server */
                API.offerCreateRequest(offer: offer, handler: { (result) in
                    if let res = result {
                        self.delegate?.confirmOfferViewController(res.item)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("create offer error: \(offer)")
                    }
                })
                
            }
        }
    }
    
}


// MARK: - UITextViewDelegate
extension ConfirmOfferViewController: UITextViewDelegate {
}
