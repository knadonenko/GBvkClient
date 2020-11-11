//
//  FriendsListViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit

class FriendsListViewController: UITableViewController {
    
    var friendsList = Friends.allFriends
    
    var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let groupedFriends = Dictionary(grouping: friendsList.keys.sorted(), by: {String($0.prefix(1))})
        let keys = groupedFriends.keys.sorted()
        
        sections = keys.map{ Section(letter: $0, names: groupedFriends[$0]!.sorted())}
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        let section = sections[indexPath.section]
        cell.friendsName.text = section.names[indexPath.row]
        cell.friendsAvatar.image = UIImage(named: friendsList[section.names[indexPath.row]]!)
        
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendAvatar" {
            
            let friendPhotoController = segue.destination as! FriendsViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let section = sections[indexPath.section]
                friendPhotoController.friendsImagePath = friendsList[section.names[indexPath.row]]
            }
            
        }
    }
    
    struct Section {
        let letter : String
        let names : [String]
    }

}
