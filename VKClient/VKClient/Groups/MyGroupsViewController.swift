//
//  MyGroupsViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit
import RealmSwift

class MyGroupsViewController: UITableViewController {

    var groupsResult: Results<GroupModel>!

    let session = Session.shared
    let network = NetworkRequests()
    let dataBase = DataBaseWorker()
    
    private let viewModelFactory = GroupViewModelFactory()
    private var viewModels: [GroupViewModel] = []

    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        network.getGroupsList(session.token)
        loadData()
    }

    func loadData() {

        guard let realm = try? Realm() else { return }
        groupsResult = realm.objects(GroupModel.self)

        notificationToken = groupsResult?.observe { [weak self] (friendsChanges: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch friendsChanges {
            case .initial:
                tableView.reloadData()
            case .update:
                self?.groupsResult = self?.dataBase.getGroupsData()!
                let groups = Array((self?.groupsResult)!)
                self?.viewModels = self?.viewModelFactory.constructViewModels(from: groups) ?? []
                tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }

        }

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! MyGroupsCell
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
//
//    @IBAction func addGroups(segue: UIStoryboardSegue) {
//
//        if segue.identifier == "addGroup" {
//
//            guard let allGroupsController = segue.source as? GroupsViewController else {
//                return
//            }
//
//            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
//
//                let groups = allGroupsController.groups[indexPath.row]
////                if !groups.contains(city) {
////                    groups.append(city)
////                    tableView.reloadData()
////                }
//
//            }
//
//        }
//
//    }

}
