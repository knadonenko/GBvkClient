//
//  MyGroupsViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit
import RealmSwift

class MyGroupsViewController: UITableViewController {
    
    var groups: [GroupModel] = []
    var groupsResult: Results<GroupModel>!

    let session = Session.shared
    let network = NetworkRequests()
    let dataBase = DataBaseWorker()

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
                self?.groups = Array((self?.groupsResult)!)
                tableView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }

        }

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! MyGroupsCell
        
        let groupName = groups[indexPath.row].name
        cell.myGroupName.text = groupName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroups(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            
            guard let allGroupsController = segue.source as? GroupsViewController else {
                return
            }
            
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                
                let groups = allGroupsController.groups[indexPath.row]
//                if !groups.contains(city) {
//                    groups.append(city)
//                    tableView.reloadData()
//                }
                
            }
            
        }
        
    }

}
