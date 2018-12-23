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
    
    private var offer: OfferRequireMatchedItem!
    private var offerItem: OfferGetDetailItem!
    private var loadingView: LoadingView?
    
    var delegate: ConfirmRequestViewControllerDelegate?
    var _parent: MainViewController?
    
    static func instantiateViewController(offer: OfferRequireMatchedItem, parent: MainViewController) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Confirm", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CRNavigationController") as! UINavigationController
        let root = viewController.viewControllers.first as! ConfirmRequestViewController
        root.offer = offer
        root.delegate = parent
        root._parent = parent
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
        tableView.register(DoubleButtonCell.nib, forCellReuseIdentifier: DoubleButtonCell.identifier)
        tableView.register(OutcomeInfoCell.nib, forCellReuseIdentifier: OutcomeInfoCell.identifier)
        tableView.register(DateInfoCell.nib, forCellReuseIdentifier: DateInfoCell.identifier)
        tableView.register(HairTypeInfoCell.nib, forCellReuseIdentifier: HairTypeInfoCell.identifier)
        tableView.register(CommentCell.nib, forCellReuseIdentifier: CommentCell.identifier)
        
        // set name
        self.navigationController?.navigationItem.title = self.offer.name
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
        API.offerGetDetailRequest(id: offer.offerId) { (result) in
            if let res = result {
                self.offerItem = res.item
                self.tableView.reloadData()
            }
        }
        
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: StylistProfileWithStarCell.identifier, for: indexPath) as? StylistProfileWithStarCell {
                if let url = self.offer.imageUrl { cell.thumbnailView.loadImage(urlString: url) }
                if let item = self.offerItem {
                    cell.setItem(item: item)
                }
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DoubleButtonCell.identifier, for: indexPath) as? DoubleButtonCell {
                cell.delegate = self
                cell.receiveMode()
                return cell
            }
            
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OutcomeInfoCell.identifier, for: indexPath) as? OutcomeInfoCell {
                if let item = self.offerItem {
                    cell.setItem(item: item)
                }
                
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DateInfoCell.identifier, for: indexPath) as? DateInfoCell {
                if let item = self.offerItem {
                    cell.setItem(item: item)
                }
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HairTypeInfoCell.identifier, for: indexPath) as? HairTypeInfoCell {
                if let item = self.offerItem {
                    cell.setItem(item: item)
                }
                return cell
            }
        
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell {
                if let item = self.offerItem {
                    cell.setItem(item: item)
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - DoubleButtonCellDelegate
extension ConfirmRequestViewController: DoubleButtonCellDelegate {
    
    func doubleButtonCell(_didSelectedOfferButton: DoubleButtonCell) {
        self.navigationController?.pushViewController(TakeOfferViewController.instantiateViewController(item: self.offerItem, parent: self._parent), animated: true)
    }
    
    func doubleButtonCell(_didSelectedProfileButton: DoubleButtonCell) {
        present(MyReviewViewController.instantiateViewController(id: self.offerItem.cxId, name: self.offerItem.cxName), animated: true, completion: nil)
    }
    
}
