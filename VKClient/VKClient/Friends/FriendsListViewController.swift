//
//  FriendsListViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit

class FriendsListViewController: UITableViewController {
    
    var friendsList = Friends.allFriends

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        let friendsName = friendsList.keys.sorted()
        let friend = friendsName[indexPath.row]
        cell.friendsName.text = friend
        cell.friendsAvatar.image = UIImage(named: friendsList[friend]!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendAvatar" {
            
            let friendPhotoController = segue.destination as! FriendsViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let friendsName = friendsList.keys.sorted()
                let friendsImagePath = friendsList[friendsName[indexPath.row]]
                friendPhotoController.friendsImagePath = friendsImagePath
            }
            
        }
    }

}
