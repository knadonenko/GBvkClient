//
//  FriendsPhotosViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 21.11.2020.
//

import UIKit

class FriendsPhotosViewController: UIViewController {
    
    var friendsImagePath: String!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedChildSegue" {
            if let childVC = segue.destination as? FriendsViewController {
                //Some property on ChildVC that needs to be set
                childVC.friendsImagePath = friendsImagePath
            }
        }
    }

}
