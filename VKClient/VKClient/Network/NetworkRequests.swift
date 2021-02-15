//
//  NetworkRequests.swift
//  VKClient
//
//  Created by Константин Надоненко on 20.12.2020.
//

import Foundation
import Alamofire

class NetworkRequests {
    
    let baseURL: String = "https://api.vk.com/method/"
    let friendsURL: String = "friends.get"
    let personalPhotoURL: String = "photos.get"
    let groupsURL: String = "groups.get"
    let groupsSearchURL: String = "groups.search"
    let newsFeed: String = "newsfeed.get"
    var accessToken: String = "&access_token="
    let version: String = "5.126"
    let database = DataBaseWorker()
    
    public func getFriendsList(_ token: String) {
        let parameters: Parameters = [
            "order": "name",
            "fields": "nickname, photo_50",
            "access_token": token,
            "v": version
        ]
        let url = baseURL + friendsURL
        AF.request(url, parameters: parameters).responseData {
            [weak self] response in
            guard let data = response.value else { return }
            let friends = try! JSONDecoder().decode(FriendsResponse.self, from: data).response.items
            friends.forEach {
                $0.date = DateHelper().currentDate
            }
            self?.database.writeFriendsData(friends)
        }

    }
    
    public func getPersonalPhotoList(_ token: String, _ userID: String, completion: @escaping () -> Void) {
        let parameters: Parameters = [
            "owner_id": userID,
            "album_id": "profile",
            "access_token": token,
            "count": 3,
            "v": version
        ]
        let url = baseURL + personalPhotoURL
        AF.request(url, method: .get, parameters: parameters).responseData {
            [weak self] response in
            guard let data = response.value else { return }
            let user = try! JSONDecoder().decode(UserResponse.self, from: data).response.items
            user.forEach{ $0.id = Int(userID) ?? 0 }
            self?.database.writeFriendsPhoto(user)
            completion()
        }
    }
    
    public func getGroupsList(_ token: String) {
        let parameters: Parameters = [
            "extended": "true",
            "access_token": token,
            "v": version
        ]
        let url = baseURL + groupsURL
        AF.request(url, parameters: parameters).responseData { [weak self] response in
            guard let data = response.value else { return }
            let groups = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
            groups.forEach {
                $0.date = DateHelper().currentDate
            }
            self?.database.writeGroupsData(groups)
        }
    }
    
    public func getGroupsSearch(_ token: String, _ query: String) {
        let parameters: Parameters = [
            "q": query,
            "count": "3",
            "access_token": token,
            "v": version
        ]
        let url = baseURL + groupsSearchURL
        AF.request(url, parameters: parameters).responseJSON {
            response in print(response.value ?? "EPIC FAIL")
        }
    }
    
    public func getNewsFeed(_ token: String, completion: @escaping ([NewsModel], [GroupModel]) -> Void) {
        let parameters: Parameters = [
            "access_token": token,
            "filters": "post",
            "count": 5,
            "fields": "name",
            "v": version
        ]
        let url = baseURL + newsFeed
        AF.request(url, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            
            var newsFeed: [NewsModel] = []
            var groups: [GroupModel] = []
            
            DispatchQueue.global().async {
                newsFeed = try! JSONDecoder().decode(NewsResponse.self, from: data).response.items
                groups = try! JSONDecoder().decode(NewsResponse.self, from: data).response.groups
                completion(newsFeed, groups)
            }
        }
    }
    
}
