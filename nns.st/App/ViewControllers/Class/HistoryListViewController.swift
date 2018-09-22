//
//  HistoryListViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/21.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class HistoryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var historyItems: [OfferHistoryListGetItem] = []
    private var _parent: MainViewController!
    
    
    static func instantiateViewController(parent: MainViewController) -> UINavigationController {
        let storyboard = UIStoryboard(name: "History", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HTNavigationController") as! UINavigationController
        let root = viewController.viewControllers.first as! HistoryListViewController
        root._parent = parent
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "履歴"
        
        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(HistoryCell.nib, forCellReuseIdentifier: HistoryCell.identifier)
        tableView.register(BlankCell.nib, forCellReuseIdentifier: BlankCell.identifier)
        
        self.fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - private
extension HistoryListViewController {
    
    private func fetch() {
        API.offerHistoryListGetRequest { (result) in
            if let res = result {
                self.historyItems = res.item
                self.tableView.reloadData()
            }
        }
    }
    
}


// MARK: - IBAction
extension HistoryListViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - UITableViewDataSource
extension HistoryListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.historyItems.count > 0) ? self.historyItems.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell {
            cell.selectionStyle = .none
            if self.historyItems.count > 0 {
                cell.setItem(item: self.historyItems[indexPath.row])
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: BlankCell.identifier, for: indexPath) as? BlankCell {
                    cell.title.text = "履歴はまだありません"
                    return cell
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
}


// MARK: - UITableViewDelegate
extension HistoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = self.historyItems[indexPath.row].id
        let name = self.historyItems[indexPath.row].name
        self.navigationController?.pushViewController(HistoryInfoViewController.instantiateViewController(offerId: id, name: name, parent: self._parent), animated: true)
    }
    
}
