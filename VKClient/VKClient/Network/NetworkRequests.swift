//
//  NetworkRequests.swift
//  VKClient
//
//  Created by Константин Надоненко on 20.12.2020.
//

import Foundation
import PromiseKit
import Alamofire

class NetworkRequests {
    
    let baseURL: String = "https://api.vk.com/method/"
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
        let url = baseURL + NetworkEndpoints.FRIENDS_URL.rawValue
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
        let url = baseURL + NetworkEndpoints.PERSONAL_PHOTO_URL.rawValue
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
        let url = baseURL + NetworkEndpoints.GROUPS_URL.rawValue
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
        let url = baseURL + NetworkEndpoints.GROUPS_SEARCH_URL.rawValue
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
        let url = baseURL + NetworkEndpoints.NEWSFEED_URL.rawValue
        AF.request(url, parameters: parameters).responseData { response in
            
            guard let data = response.value else { return }
            
            var newsFeed: [NewsModel] = []
            var groups: [GroupModel] = []
            
            let dispatchGroup = DispatchGroup()
            
            DispatchQueue.global().async(group: dispatchGroup) {
                newsFeed = try! JSONDecoder().decode(NewsResponse.self, from: data).response.items
            }
            
            DispatchQueue.global().async(group: dispatchGroup) {
                groups = try! JSONDecoder().decode(NewsResponse.self, from: data).response.groups
            }
            dispatchGroup.notify(queue: DispatchQueue.main) {
                completion(newsFeed, groups)
            }
        }
    }

    public func likes(_ token: String, postOwner ownerID: String, _ postID: String, _ likes: String) {
        let parameters: Parameters = [
            "type": "post",
            "owner_id": ownerID,
            "item_id": postID,
            "access_token": token,
            "v": "5.130"
        ]

        var url = ""

        switch likes {
        case "add":
            url = baseURL + NetworkEndpoints.LIKES_ADD.rawValue
        case "delete":
            url = baseURL + NetworkEndpoints.LIKES_DELETE.rawValue
        default: print("Error!")
        }

        AF.request(url, parameters: parameters).responseData { [weak self] response in
            guard let data = response.value else { return }
        }

    }

    public func getNews(_ token: String) -> Promise<[NewsModel]> {

        let parameters: Parameters = [
            "access_token": token,
            "filters": "post",
            "count": 5,
            "fields": "name",
            "v": version
        ]
        let url = baseURL + NetworkEndpoints.NEWSFEED_URL.rawValue

        return Promise<[NewsModel]> { resolver in
            AF.request(url, parameters: parameters).responseData { response in
                switch response.result {
                case .success(let data):
                    var newsFeed: [NewsModel] = []
                    newsFeed = try! JSONDecoder().decode(NewsResponse.self, from: data).response.items
                    resolver.fulfill(newsFeed)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
    }
    
}
