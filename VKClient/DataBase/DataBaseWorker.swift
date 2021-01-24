//
// Created by Константин Надоненко on 16.01.2021.
//

import Foundation
import RealmSwift

class DataBaseWorker {

    let date = DateHelper().currentDate

    func writeFriendsData(_ friends: [FriendsModel]) {
        do {
            let realm = try Realm()
            let oldData = realm.objects(FriendsModel.self)
            realm.beginWrite()
            deleteOldData(oldData, realmInstance: realm)
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func writeGroupsData(_ groups: [GroupModel]) {
        do {
            let realm = try Realm()
            let oldData = realm.objects(GroupModel.self)
            realm.beginWrite()
            deleteOldData(oldData, realmInstance: realm)
            realm.add(groups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func writeFriendsPhoto(_ userData: [User]) {
        do {
            let realm = try Realm()
            let oldData = realm.objects(User.self)
            realm.beginWrite()
            deleteOldData(oldData, realmInstance: realm)
            realm.add(userData)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func getFriendsData() -> Results<FriendsModel>? {
        do {
            let realm = try Realm()
            let friends = realm.objects(FriendsModel.self).filter("date = %@", date)
            return friends
        } catch {
            print(error)
            return nil
        }

    }

    func getGroupsData() -> Results<GroupModel>? {
        do {
            let realm = try Realm()
            let groups = realm.objects(GroupModel.self).filter("date = %@", date)
            return groups
        } catch {
            print(error)
            return nil
        }
    }

    func getUserData(_ id: Int) -> [User] {
        do {
            let realm = try Realm()
            let user = realm.objects(User.self).filter("id == %@", id)
            return Array(user)
        } catch {
            print(error)
            return []
        }
    }

    private func deleteOldData<T: Object>(_ oldData: Results<T>, realmInstance: Realm) {
        realmInstance.delete(oldData)
    }

}