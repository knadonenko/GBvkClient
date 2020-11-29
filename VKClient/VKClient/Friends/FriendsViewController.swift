//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit

class FriendsViewController: HorizontalPagingCollectionView {
    
    var friendsImagePath: String!
    var numImages = 4
    var newCellIndexPath = IndexPath(row: 0, section: 0)
    var oldCellIndexPath = IndexPath(row: 0, section: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numImages
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhoto", for: indexPath) as! FriendsPhotoCell
        cell.photo.image = UIImage(named: friendsImagePath)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 1) {
            cell.alpha = 1
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
}
