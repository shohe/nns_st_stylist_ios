//
//  BottomSheetViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/18.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit

protocol BottomSheetDelegate {
    func bottomSheet(_ bottomSheet: BottomSheetViewController, didCanceled items: [MKMapItem])
    func bottomSheet(_ bottomSheet: BottomSheetViewController, SearchButtonClicked items: [MKMapItem])
    func bottomSheet(_bottmSheet: BottomSheetViewController, didScrolledSlider slider: UISlider)
    func bottomSheet(_bottmSheet: BottomSheetViewController, didSetDistance button: UIButton)
}

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var km: UILabel!
    @IBOutlet weak var cancelRightConst: NSLayoutConstraint!
    @IBOutlet weak var cancelLeftConst: NSLayoutConstraint!
    @IBOutlet weak var cancelWidth: NSLayoutConstraint!
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var tableView: UITableView!
    var matchingItems:[MKMapItem] = []
    var mapview: MKMapView? = nil
    var delegate: BottomSheetDelegate? = nil
    
    static func instantiateViewController() -> BottomSheetViewController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
        
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareBackgroundView()
        self.configureObserver()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initBottomSheet()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        self.slider.addTarget(self, action: #selector(onChanged(_:)), for: .valueChanged)
//        slider.addTarget(self, action: #selector(self.onChange), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObserver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension BottomSheetViewController {
    
    func prepareBackgroundView() {
        let blurEffect = UIBlurEffect.init(style: .extraLight)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.alpha = 0.7
        bluredView.contentView.addSubview(visualEffect)
        
        let radius = view.layer.cornerRadius
        visualEffect.frame = UIScreen.main.bounds
        visualEffect.contentView.layer.cornerRadius = radius
        bluredView.frame = UIScreen.main.bounds
        bluredView.contentView.layer.cornerRadius = radius
        
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
        view.layer.shadowRadius = 10
        
        view.insertSubview(bluredView, at: 0)
    }
    
    func initBottomSheet() {
        UIView.animate(withDuration: 0.3) {
            let frame = self.view.frame
            let componentY = UIScreen.main.bounds.height - self.containerView.frame.height
            self.view.frame = CGRect(x: 0, y: componentY, width: frame.width, height: frame.height)
        }
    }
    
    func initTableView() {
        tableView = UITableView()
        tableView.frame = CGRect(x: 0.0, y: searchBar.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height - searchBar.frame.size.height)
        tableView.backgroundColor = .clear
        tableView.tag = 99
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(SearchResultCell.nib, forCellReuseIdentifier: SearchResultCell.identifier)
    }
    
    
    func showTableView() {
        distanceLabel.isHidden = true
        slider.isHidden = true
        km.isHidden = true
        setButton.isHidden = true
        self.view.addSubview(tableView)
    }
    
    func hideTableView() {
        distanceLabel.isHidden = false
        slider.isHidden = false
        km.isHidden = false
        setButton.isHidden = false
        if let vtag = self.view.viewWithTag(99) {
            vtag.removeFromSuperview()
        }
    }
    
    func updateTableViewInset(keyboadHeight: CGFloat) {
        let margin: CGFloat = 30.0
        let insets: UIEdgeInsets = UIEdgeInsets(top: -margin, left: 0, bottom: keyboadHeight + searchBar.frame.size.height + margin, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeObserver() {
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification?) {
        if let userInfo = notification?.userInfo {
            if let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue, let _ = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {

                self.view.transform = CGAffineTransform.identity
                let convertedKeyboardFrame = self.view.convert(keyboardFrame, from: nil)
//                let height = (matchingItems.count > 0) ? self.view.frame.height/2 : self.searchBar!.frame.maxY
                let height = self.view.frame.height/2
                let offsetY: CGFloat = height - convertedKeyboardFrame.minY
                if offsetY < 0 { return }
                
                self.view.transform = CGAffineTransform(translationX: 0, y: -offsetY)
                self.updateTableViewInset(keyboadHeight: keyboardFrame.height)
                self.showTableView()
                
                self.showCancel()
                self.delegate?.bottomSheet(self, didCanceled: matchingItems)
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.transform = CGAffineTransform.identity
            self.hideTableView()
            self.hideCancel()
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        })
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        searchBar.resignFirstResponder()
        self.delegate?.bottomSheet(self, didCanceled: matchingItems)
    }
    
    func showCancel() {
        UIView.animate(withDuration: 2.0) {
            self.cancelRightConst.constant = 14.0
            self.cancelLeftConst.constant = 5.0
            self.cancelWidth.constant = 48.0
            self.view.layoutIfNeeded()
        }
    }
    
    func hideCancel() {
        UIView.animate(withDuration: 2.0) {
            self.cancelRightConst.constant = 0.0
            self.cancelLeftConst.constant = 0.0
            self.cancelWidth.constant = 0.0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func setDistance(_ sender: UIButton) {
        delegate?.bottomSheet(_bottmSheet: self, didSetDistance: sender)
    }
    
    @objc func onChanged(_ sender: UISlider) {
        distanceLabel.text = String("\(round(sender.value * 10) / 10)")
        delegate?.bottomSheet(_bottmSheet: self, didScrolledSlider: sender)
    }
}



extension BottomSheetViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.delegate?.bottomSheet(self, SearchButtonClicked: matchingItems)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let mapView = mapview, let searchBarText = searchBar.text else { return true }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
        return true
    }
    
}



extension BottomSheetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier, for: indexPath) as! SearchResultCell

        let selectedItem = matchingItems[indexPath.row]
        cell.name.text = selectedItem.name
        cell.address.text = selectedItem.placemark.title
        cell.placemark = selectedItem.placemark
        return cell
    }
    
}
