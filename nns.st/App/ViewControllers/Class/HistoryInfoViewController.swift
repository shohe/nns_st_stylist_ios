//
//  HistoryInfoViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/22.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class HistoryInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var isCurrentOrder: Bool = false
    private var id: Int?
    private var currentItem: OfferGetDetailItem?
    private var historyItem: OfferHistoryDetailGetItem?
    private var loadingView: LoadingView?
    private var stylistStar: Int?
    private var _parent: MainViewController!
    
    static func instantiateViewController(offerId: Int, name: String?, parent: MainViewController) -> HistoryInfoViewController {
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HistoryInfoViewController") as! HistoryInfoViewController
        viewController.id = offerId
        viewController.isCurrentOrder = false
        viewController.navigationItem.title = name
        viewController._parent = parent
        return viewController
    }
    
    static func instantiateNavigationController(offerId: Int) -> UINavigationController {
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HINavigationController") as! UINavigationController
        let root = viewController.viewControllers.first as! HistoryInfoViewController
        root.id = offerId
        root.isCurrentOrder = true
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(StylistProfileWithStarCell.nib, forCellReuseIdentifier: StylistProfileWithStarCell.identifier)
        tableView.register(DoubleButtonCell.nib, forCellReuseIdentifier: DoubleButtonCell.identifier)
        tableView.register(SingleButtonCell.nib, forCellReuseIdentifier: SingleButtonCell.identifier)
        tableView.register(OutcomeInfoCell.nib, forCellReuseIdentifier: OutcomeInfoCell.identifier)
        tableView.register(DateInfoCell.nib, forCellReuseIdentifier: DateInfoCell.identifier)
        tableView.register(DistanceInfoCell.nib, forCellReuseIdentifier: DistanceInfoCell.identifier)
        tableView.register(HairTypeInfoCell.nib, forCellReuseIdentifier: HairTypeInfoCell.identifier)
        tableView.register(CommentCell.nib, forCellReuseIdentifier: CommentCell.identifier)
        
        self.fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - UITableViewDataSource
extension HistoryInfoViewController: UITableViewDataSource {
    
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
                if self.isCurrentOrder {
                    cell.setItem(item: self.currentItem)
                } else {
                    cell.setItem(item: self.historyItem, star: self.stylistStar)
                }
                return cell
            }
        case 1:
            if self.isCurrentOrder {
                if let cell = tableView.dequeueReusableCell(withIdentifier: SingleButtonCell.identifier, for: indexPath) as? SingleButtonCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    return cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: DoubleButtonCell.identifier, for: indexPath) as? DoubleButtonCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    return cell
                }
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: OutcomeInfoCell.identifier, for: indexPath) as? OutcomeInfoCell {
                if self.isCurrentOrder {
                    cell.setItem(item: self.currentItem)
                } else {
                    cell.setItem(item: self.historyItem)
                }
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DateInfoCell.identifier, for: indexPath) as? DateInfoCell {
                if self.isCurrentOrder {
                    cell.setItem(item: self.currentItem)
                } else {
                    cell.setItem(item: self.historyItem)
                }
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HairTypeInfoCell.identifier, for: indexPath) as? HairTypeInfoCell {
                if self.isCurrentOrder {
                    cell.setItem(item: self.currentItem)
                } else {
                    cell.setItem(item: self.historyItem)
                }
                return cell
            }
            
        case 5:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell {
                if self.isCurrentOrder {
                    cell.setItem(item: self.currentItem)
                } else {
                    cell.setItem(item: self.historyItem)
                }
                return cell
            }
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - DoubleButtonCellDelegate
extension HistoryInfoViewController: DoubleButtonCellDelegate {
    func doubleButtonCell(_didSelectedOfferButton: DoubleButtonCell) {
        var stylist = User()
        stylist.id = self.historyItem?.id
        stylist.name = self.navigationItem.title
        stylist.salonName = self.historyItem?.salonName
        stylist.imageUrl = self.historyItem?.imageUrl
        self.present(MakeOfferViewController.instantiateViewController(stylist: stylist, parent: self._parent), animated: true, completion: nil)
    }
    
    func doubleButtonCell(_didSelectedProfileButton: DoubleButtonCell) {
        if let id = self.historyItem?.id {
            self.present(ProfileViewController.instantiateViewController(id: id, name: self.navigationItem.title), animated: true, completion: nil)
        }
    }
}


// MARK: - SingleButtonCellDelegate
extension HistoryInfoViewController: SingleButtonCellDelegate {
    
    func singleButtonCell(_ didSelectedButton: PriceButton) {
        loadingView = LoadingView(frame: self.view.bounds)
        self.view.addSubview(loadingView!)
        
        if let id = self.id {
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingView!.alpha = 1
            }) { (complete) in
                /* cancel offer */
                API.offerCancelRequest(id: id) { (result) in
                    if result != nil {
                        NNSCore.setMadeOfferId(0)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }

    }
    
}


// MARK: - UITableViewDelegate
extension HistoryInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.addBottomSpaceView()
    }
    
}


// MARK: - private function
extension HistoryInfoViewController {
    
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
    
    private func fetch() {
        if self.isCurrentOrder {
            self.fetchCurrent()
        } else {
            self.fetchHistory()
        }
    }
    
    private func fetchCurrent() {
        API.offerGetDetailRequest(id: self.id!) { (result) in
            if let res = result {
                self.currentItem = res.item
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchHistory() {
        API.offerHistoryDetailGetRequest(id: self.id!) { (result) in
            if let res = result {
                self.historyItem = res.item
                self.stylistStar = res.star
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - IBAction
extension HistoryInfoViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
