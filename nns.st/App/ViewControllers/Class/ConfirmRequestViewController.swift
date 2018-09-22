//
//  ConfirmRequestViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit


protocol ConfirmRequestViewControllerDelegate {
    func confirmRequestView(_ didMakeReservation: Bool)
}

class ConfirmRequestViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var request: OfferRequireMatchedItem!
    private var requestItem: RequestDetailGetResponse!
    private var loadingView: LoadingView?
    
    var delegate: ConfirmRequestViewControllerDelegate?
    
    static func instantiateViewController(request: OfferRequireMatchedItem, parent: UIViewController) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Confirm", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CRNavigationController") as! UINavigationController
        let root = viewController.viewControllers.first as! ConfirmRequestViewController
        root.request = request
        root.delegate = parent as? ConfirmRequestViewControllerDelegate
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchRequest()
        
        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(StylistProfileWithStarCell.nib, forCellReuseIdentifier: StylistProfileWithStarCell.identifier)
        tableView.register(PriceButtonCell.nib, forCellReuseIdentifier: PriceButtonCell.identifier)
        tableView.register(SalonAddressCell.nib, forCellReuseIdentifier: SalonAddressCell.identifier)
        tableView.register(CommentCell.nib, forCellReuseIdentifier: CommentCell.identifier)
        tableView.register(ReviewCell.nib, forCellReuseIdentifier: ReviewCell.identifier)
        
        // set name
        self.navigationController?.navigationItem.title = self.request.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - IBAction
extension ConfirmRequestViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - private function
extension ConfirmRequestViewController {
    
    private func addBottomSpaceView() {
        for view in self.tableView.subviews {
            if view.tag == 99 {
                view.removeFromSuperview()
            }
        }
        
        let origin: CGPoint = CGPoint(x: 0, y: tableView.contentSize.height)
        let size: CGSize = self.view.frame.size
        let view = UIView(frame: CGRect(origin: origin, size: size))
        view.backgroundColor = .white
        view.tag = 99
        self.tableView.addSubview(view)
    }
    
    private func fetchRequest() {
//        API.requestDetailGetRequest(id: self.request.requestId) { (result) in
//            if let res = result {
//                self.requestItem = res
//                self.tableView.reloadData()
//            }
//        }
    }
    
    private func setSnapShotToCell(cell: SalonAddressCell, salonLocation: SalonLocation?) {
        if let location = salonLocation {
            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
            SnapShotMaker.drawSnapshot(coordinate: coordinate, source: cell.mapSnap, pinColor: cell.pinColor)
        }
    }
    
}


// MARK: - UITableViewDelegate
extension ConfirmRequestViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.addBottomSpaceView()
    }
    
}


// MARK: - UITableViewDataSource
extension ConfirmRequestViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = self.requestItem {
            return item.reviews.count + 4
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: StylistProfileWithStarCell.identifier, for: indexPath) as? StylistProfileWithStarCell {
                if let url = self.request.imageUrl { cell.thumbnailView.loadImage(urlString: url) }
                if let item = self.requestItem {
                    /* show blank star => +10 */
                    cell.starView.setStar(number: Int(item.average) + 10)
                    cell.statusComment.text = (item.stylist.statusComment != "") ? item.stylist.statusComment : "I AM \(item.stylist.name!)"
                }
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PriceButtonCell.identifier, for: indexPath) as? PriceButtonCell {
                cell.selectionStyle = .none
                cell.delegate = self as PriceButtonCellDelegate
                if let item = self.requestItem {
                    cell.setPrice(price: item.request.price, currency: .JPY)
                }
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SalonAddressCell.identifier, for: indexPath) as? SalonAddressCell {
                
                if let item = self.requestItem {
                    self.setSnapShotToCell(cell: cell, salonLocation: item.stylist.salonLocation)
                    cell.salonName.text = item.stylist.salonName
                    let address = item.stylist.salonAddress?.split(separator: "/")
                    if address?.count == 3 {
                        cell.postCode.text = "〒\(String(address![0]))"
                        cell.city.text = String(address![1])
                        cell.street.text = String(address![2])
                    } else {
                        cell.postCode.isHidden = true
                        cell.city.isHidden = true
                        cell.streetTopConst.constant = -30
                        cell.street.text = item.stylist.salonAddress
                    }
                }
                
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell {
                if let item = self.requestItem {
                    cell.comment.text = item.request.comment
                }
                return cell
            }
        
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell {
                
                if indexPath.row != 4 { cell.nonTitle() }
                if let item = self.requestItem {
                    cell.userName.text = item.reviews[indexPath.row - 4].name
                    cell.comment.text = item.reviews[indexPath.row - 4].comment
                    cell.date.text = item.reviews[indexPath.row - 4].date
                    /* show blank star => +10 */
                    cell.starView.setStar(number: item.reviews[indexPath.row - 4].star + 10 )
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - PriceButtonCellDelegate
extension ConfirmRequestViewController: PriceButtonCellDelegate {
    
    func priceButtonCell(_ didSelectedButton: PriceButton) {
        self.loadingView = LoadingView(frame: self.view.bounds)
        self.view.addSubview(self.loadingView!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView!.alpha = 1
        }) { (complete) in
//            API.requestTakeRequest(id: self.request.requestId, handler: { (result) in
//                if let res = result {
//                    if res.isSuccess {
//                        self.delegate?.confirmRequestView(res.isSuccess)
//                        self.dismiss(animated: true, completion: nil)
//                    } else {
//                        print("take request: error")
//                    }
//                } else {
//                    print("take request: error")
//                }
//            })
        }
    }
    
}
