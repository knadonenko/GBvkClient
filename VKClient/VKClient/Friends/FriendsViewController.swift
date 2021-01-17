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
    var userPhotos: [String] = []
    let session = Session.shared
    let network = NetworkRequests()
    var user: [User] = []
    var id: Int = 0
    var dataBase = DataBaseWorker()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        network.getPersonalPhotoList(session.token, "\(id)") { [weak self] in
            self?.user = (self?.dataBase.getUserData(self?.id ?? 0) ?? [])
            self?.collectionView.reloadData()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhoto", for: indexPath) as! FriendsPhotoCell

        let url = URL(string: user[indexPath.row].sizes[2].url ?? "")
        cell.photo.load(url: url!)

        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.alpha = 0
//        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//        UIView.animate(withDuration: 1) {
//            cell.alpha = 1
//            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//        }
//    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
