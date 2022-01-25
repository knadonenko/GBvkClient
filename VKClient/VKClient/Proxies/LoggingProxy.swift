//
//  LoggingProxy.swift
//  VKClient
//
//  Created by Константин Надоненко on 05.04.2021.
//

import Foundation

class LoggingProxy: NetworkServiceInterface {
    
    let network: NetworkServiceInterface
    
    init(networkService: NetworkServiceInterface) {
        network = networkService
    }
    
    func getFriendsList(_ token: String) {
        print("--------------------------Retrieving friends data----------------------------")
        network.getFriendsList(token)
    }
}
