//
//  MainViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/14.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBInspectable var itemWidth: CGFloat = 0.0
    
    private var items: [OfferRequireMatchedItem] = []
    
    
    static func instantiateViewController() -> MainViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! MainViewController
        
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let layout = collectionView.collectionViewLayout as! CarouselFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: collectionView.frame.size.height)
        
        let inset = (UIScreen.main.bounds.width - itemWidth) / 2.0
        layout.sectionInset = UIEdgeInsetsMake(0.0, inset, 0.0, inset)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ThreeColumnCell.nib, forCellWithReuseIdentifier: ThreeColumnCell.identifier)
        fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - private
extension MainViewController {
    
    private func fetch() {
        API.offerRequireMatchedRequest { (result) in
            if let res = result {
                for var item in res.located {
                    item.isNominated = false
                    self.items.append(item)
                }
                for var item in res.nominated {
                    item.isNominated = true
                    self.items.append(item)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
}


// MARK: - IBAction
extension MainViewController {
    
    @IBAction func pressListBtn(_ sender: UIButton) {
        print("pressListBtn()")
    }
    
    @IBAction func pressHistoryBtn(_ sender: UIButton) {
        self.present(HistoryListViewController.instantiateViewController(parent: self), animated: true, completion: nil)
    }
    
    @IBAction func pressMyReviewBtn(_ sender: UIButton) {
        self.present(MyReviewViewController.instantiateViewController(), animated: true, completion: nil)
    }
    
}


// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.present(MyPageViewController.instantiateViewController(), animated: true, completion: nil)
        } else {
            let item = items[indexPath.row-1] // -1 for mypage
            self.present(ConfirmRequestViewController.instantiateViewController(request: item, parent: self), animated: true, completion: nil)
        }
    }
    
}


// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1 // +1 for mypage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeColumnCell.identifier, for: indexPath) as! ThreeColumnCell
        
        if indexPath.row == 0 {
            cell.nameLabel.isHidden = true
        } else {
            let item = items[indexPath.row-1]
            cell.nameLabel.isHidden = false
            cell.nameLabel.text = item.name
            
            if item.isNominated! { cell.nameLabel.textColor = .yellow }
            
            
            if let url = item.imageUrl {
                cell.thumbnailView.loadImage(urlString: url)
            }
        }
        
        return cell
    }
    
}


// MARK: - ConfirmRequestViewControllerDelegate
extension MainViewController: ConfirmRequestViewControllerDelegate {
    
    func confirmRequestView(_ didMakeReservation: Bool) {
        NNSCore.setWaitState(didMakeReservation)
        
        // reset layout
        let layout:CarouselFlowLayout = self.collectionView.collectionViewLayout as! CarouselFlowLayout
        layout.sideItemScale = 1.0
        layout.sideItemAlpha = 1.0
        
        self.fetch()
    }
    
}


extension MainViewController: ConfirmOfferViewControllerDelegate {
    
    func confirmOfferViewController(_ didCreateOffer: Offer) {
        NNSCore.setMadeOfferId(didCreateOffer.id!)
        NNSCore.setDealUserId(didCreateOffer.stylistId!)
    }
    
}
