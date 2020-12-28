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
    var accessToken: String = "&access_token="
    let version: String = "5.126"
    
    public func getFriendsList(_ token: String, completion: @escaping ([FriendsModel]) -> Void) {
        let parameters: Parameters = [
            "order": "name",
            "fields": "nickname, photo_50",
            "count": 5,
            "access_token": token,
            "v": version
        ]
        let url = baseURL + friendsURL
        AF.request(url, parameters: parameters).responseData {
            response in
            guard let data = response.value else { return }
            let friends = try! JSONDecoder().decode(FriendsResponse.self, from: data).response.items
            completion(friends)
        }

    }
    
    public func getPersonalPhotoList(_ token: String, _ userID: String, completion: @escaping ([User]) -> Void) {
        let parameters: Parameters = [
            "owner_id": userID,
            "album_id": "profile",
            "access_token": token,
            "count": 3,
            "v": version
        ]
        let url = baseURL + personalPhotoURL
        AF.request(url, method: .get, parameters: parameters).responseData {
            response in
            guard let data = response.value else { return }
            let user = try! JSONDecoder().decode(UserResponse.self, from: data).response.items
            print("\(user[0].sizes[2].url)")
            completion(user)
        }
    }
    
    public func getGroupsList(_ token: String, completion: @escaping ([GroupModel]) -> Void) {
        let parameters: Parameters = [
            "extended": "true",
            "access_token": token,
            "v": version
        ]
        let url = baseURL + groupsURL
        AF.request(url, parameters: parameters).responseData { response in
            guard let data = response.value else { return }
            let groups = try! JSONDecoder().decode(GroupResponse.self, from: data).response.items
            completion(groups)
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
    
}
