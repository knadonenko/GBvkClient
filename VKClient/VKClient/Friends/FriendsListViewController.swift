//
//  FriendsListViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit

class FriendsListViewController: UITableViewController, UISearchBarDelegate {
    
    var friendsList = Friends.allFriends
    var filteredFriendsList: [Section]!
    var searchActive = false
    
    var sections = [Section]()
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imgTap(tapGesture:)))
        tapGesture.numberOfTapsRequired = 1
        cell.friendsAvatar.isUserInteractionEnabled = true
        cell.friendsAvatar.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    @objc func imgTap(tapGesture: UITapGestureRecognizer) {
        let imgView = tapGesture.view as! UIImageView
        imgView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: { imgView.transform = .identity},
                       completion: nil)
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sections = sections.filter{ $0.names.contains(where: {$0.range(of: searchText, options: [.caseInsensitive, .anchored]) != nil}) }
        
        if(searchText.count == 0) {
            loadInitialData()
        }

        tableView.reloadData()
    }
    
    func loadInitialData() {
        let groupedFriends = Dictionary(grouping: friendsList.keys.sorted(), by: {String($0.prefix(1))})
        let keys = groupedFriends.keys.sorted()
        
        sections = keys.map{ Section(letter: $0, names: groupedFriends[$0]!.sorted())}
    }

}
