//
//  FriendsListViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit
import RealmSwift

class FriendsListViewController: UITableViewController, UISearchBarDelegate {

    var searchActive = false

    let session = Session.shared
    let network = NetworkRequests()
    var friends: Results<FriendsModel>?
    let database = DataBaseWorker()

    var friendsSection = FriendsSections()
    var sections: [FriendsSections] = []

    var notificationToken: NotificationToken?

    @IBOutlet weak var friendsSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        network.getFriendsList(session.token)
        loadData()
    }

    func loadData() {
        guard let realm = try? Realm() else { return }
        friends = realm.objects(FriendsModel.self)
        notificationToken = friends?.observe { [weak self] friendsChanges in
            guard let tableView = self?.tableView else { return }
            switch friendsChanges {
            case .initial:
                tableView.reloadData()
            case .update:
                self?.friends = self?.database.getFriendsData()
                self?.sections = self?.friendsSection.mapToSection(Array((self?.friends)!)) ?? []
                tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        }

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

        //todo: return it later
//        cell.friendsAvatar.image = UIImage(named: friendsList[section.names[indexPath.row]]!)

//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imgTap(tapGesture:)))
//        tapGesture.numberOfTapsRequired = 1
//        cell.friendsAvatar.isUserInteractionEnabled = true
//        cell.friendsAvatar.addGestureRecognizer(tapGesture)

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
                animations: { imgView.transform = .identity },
                completion: nil)
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map {
            $0.letter
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFriendAvatar" {

            let friendPhotoController = segue.destination as! FriendsPhotosViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                friendPhotoController.id = friends![indexPath.row].id
            }

        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sections = sections.filter {
            $0.names.contains(where: { $0.range(of: searchText, options: [.caseInsensitive, .anchored]) != nil })
        }

        if (searchText.count == 0) {
//            loadInitialData()
        }

        tableView.reloadData()
    }

}
