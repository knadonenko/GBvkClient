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
    let personalPhotoURL: String = "users.get"
    let groupsURL: String = "groups.get"
    let groupsSearchURL: String = "groups.search"
    var accessToken: String = "&access_token="
    let version: String = "5.126"
    
    public func getFriendsList(_ token: String) {
        let parameters: Parameters = [
            "order": "name",
            "access_token": token,
            "v": version
        ]
        let url = baseURL + friendsURL
        AF.request(url, parameters: parameters).responseJSON {
            response in print(response.value ?? "EPIC FAIL")
        }
    }
    
    public func getPersonalPhotoList(_ token: String, _ userID: String) {
        let parameters: Parameters = [
            "user_ids": userID,
            "fields": "photo_50",
            "access_token": token,
            "v": version
        ]
        let url = baseURL + personalPhotoURL
        AF.request(url, parameters: parameters).responseJSON {
            response in print(response.value ?? "EPIC FAIL")
        }
    }
    
    public func getGroupsList(_ token: String) {
        let parameters: Parameters = [
            "extended": "true",
            "access_token": token,
            "v": version
        ]
        let url = baseURL + groupsURL
        AF.request(url, parameters: parameters).responseJSON {
            response in print(response.value ?? "EPIC FAIL")
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
