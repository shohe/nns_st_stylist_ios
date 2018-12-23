//
//  MyReviewViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/30.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MyReviewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var item: OwnReviewGetResponse?
    private var id: Int?
    
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MRNavigationController") as! UINavigationController
        return viewController
    }
    
    static func instantiateViewController(id: Int, name: String) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MRNavigationController") as! UINavigationController
        let root = viewController.viewControllers.first as! MyReviewViewController
        root.id = id
        root.navigationItem.title = name
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(StylistProfileWithStarCell.nib, forCellReuseIdentifier: StylistProfileWithStarCell.identifier)
        tableView.register(ReviewAverageCell.nib, forCellReuseIdentifier: ReviewAverageCell.identifier)
        tableView.register(ReviewCell.nib, forCellReuseIdentifier: ReviewCell.identifier)
        tableView.register(BlankCell.nib, forCellReuseIdentifier: BlankCell.identifier)
        
        self.fetch(id: self.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// MARK: - IBAction
extension MyReviewViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - private
extension MyReviewViewController {
    
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
    
    private func fetch(id: Int?) {
        API.reviewGetRequest(id: id) { (result) in
            if let res = result {
                self.item = res
                self.tableView.reloadData()
            }
        }
    }
    
}


// MARK: - UITableViewDelegate
extension MyReviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.addBottomSpaceView()
    }
    
}


// MARK: - UITableViewDataSource
extension MyReviewViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = self.item {
            return (item.item.count > 0) ? item.item.count + 2 : 3
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: StylistProfileWithStarCell.identifier, for: indexPath) as? StylistProfileWithStarCell {
                if let item = self.item {
                    cell.setItem(item: item)
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
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell {
                if indexPath.row != 2 { cell.nonTitle() }
                if let item = self.item {
                    if item.item.count > 0 {
                        cell.setItem(item: item.item[indexPath.row-2])
                    } else {
                        if let cell = tableView.dequeueReusableCell(withIdentifier: BlankCell.identifier, for: indexPath) as? BlankCell {
                            return cell
                        }
                    }
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}
