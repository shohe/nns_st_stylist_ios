//
//  CharityListViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/23.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class CharityListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Charity", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // row height automatic
        tableView.rowHeight = UITableViewAutomaticDimension
        // register cells
        tableView.register(CharityCell.nib, forCellReuseIdentifier: CharityCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - IBAction
extension CharityListViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - UITableViewDataSource
extension CharityListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CharityCell.identifier, for: indexPath) as? CharityCell {
            cell.selectionStyle = .none
            cell.delegate = self
            cell.charityId = indexPath.row  // todo: chnage to real id later
            
            if cell.charityId == 1 {
                cell.setCharity(anim: false)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
}


// MARK: - UITableViewDelegate
extension CharityListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(CharityDetailViewController.instantiateViewController(), animated: true)
    }
    
}


// MARK: - CharityCellDelegate
extension CharityListViewController: CharityCellDelegate {
    
    func charityCell(cell: CharityCell, _didSelectedCharity sender: UIButton) {
        if let charityCells = self.tableView.visibleCells as? [CharityCell] {
            for _cell in charityCells {
                if _cell.charityId == cell.charityId {
                    _cell.setCharity(anim: true)
                } else {
                    _cell.resetCharity(anim: true)
                }
            }
        }
    }
    
}
