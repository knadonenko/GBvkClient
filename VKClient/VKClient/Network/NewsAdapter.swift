//
//  NewsAdapter.swift
//  VKClient
//
//  Created by Константин Надоненко on 29.03.2021.
//

import Foundation

protocol NewsAdapterProtocol: class {
    func getNews(_ token: String, completion: @escaping ([NewsModel], [GroupModel]) -> Void)
}

class NewsAdapter: NewsAdapterProtocol {
    
    private let networkService = NetworkRequests()
    
    func getNews(_ token: String, completion: @escaping ([NewsModel], [GroupModel]) -> Void) {
        networkService.getNewsFeed(token) { data in
            
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

}
