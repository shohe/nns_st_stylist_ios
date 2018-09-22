//
//  ProfileViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/23.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var id: Int = 0
    private var item: OwnReviewGetResponse!
    
    
    static func instantiateViewController(id: Int, name: String?) -> UIViewController {
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PFNavigationController") as! UINavigationController
        let root = viewController.viewControllers.first as! ProfileViewController
        root.id = id
        root.navigationItem.title = name
        return viewController
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(StylistProfileWithStarCell.nib, forCellReuseIdentifier: StylistProfileWithStarCell.identifier)
        tableView.register(ReviewAverageCell.nib, forCellReuseIdentifier: ReviewAverageCell.identifier)
        tableView.register(SalonAddressCell.nib, forCellReuseIdentifier: SalonAddressCell.identifier)
        tableView.register(ReviewCell.nib, forCellReuseIdentifier: ReviewCell.identifier)
        
        self.fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - IBAction / private
extension ProfileViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
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
        API.reviewGetRequest(id: self.id) { (result) in
            if let res = result {
                self.item = res
                self.tableView.reloadData()
            }
        }
    }
    
}


// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.addBottomSpaceView()
    }
    
}


// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = self.item {
            return item.item.count + 3
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: StylistProfileWithStarCell.identifier, for: indexPath) as? StylistProfileWithStarCell {
                if let item = self.item {
                    cell.setItem(item: item.user, star: Int(round(item.evaluate.average)))
                }
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewAverageCell.identifier, for: indexPath) as? ReviewAverageCell {
                if let item = self.item {
                    cell.setItem(item: item.evaluate)
                }
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SalonAddressCell.identifier, for: indexPath) as? SalonAddressCell {
                if let item = self.item {
                    cell.setItem(item: item)
                }
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell {
                if indexPath.row != 3 { cell.nonTitle() }
                if let item = self.item {
                    cell.setItem(item: item.item[indexPath.row-3])
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}
