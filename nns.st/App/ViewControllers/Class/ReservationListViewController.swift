//
//  ReservationListViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/30.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ReservationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var items: [ReservationListGetItem] = []
    
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Reservation", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RLNavigationController") as! UINavigationController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cells
        tableView.register(HistoryCell.nib, forCellReuseIdentifier: HistoryCell.identifier)
        tableView.register(BlankCell.nib, forCellReuseIdentifier: BlankCell.identifier)
        
        self.fetch()
    }

}


// MARK: - private
extension ReservationListViewController {
    
    private func fetch() {
        API.reservationListGetRequest { (result) in
            if let res = result {
                self.items = res.item
                self.tableView.reloadData()
            }
        }
    }
    
}


// MARK: - IBAction
extension ReservationListViewController {
    
    @IBAction func pushBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - UITableViewDataSource
extension ReservationListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell {
            cell.selectionStyle = .none
            if self.items.count > 0 {
                cell.setItem(item: self.items[indexPath.row])
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
extension ReservationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
