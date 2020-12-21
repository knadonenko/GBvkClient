//
//  Session.swift
//  VKClient
//
//  Created by Константин Надоненко on 17.12.2020.
//

import Foundation

class Session {
    
    private init() {}
    
    var token: String!
    var userId: Int!
    
    static var shared: Session = {
        //Мало ли вдруг надо будет настраивать чего отсюда
        let instance = Session()
        return instance
    }()
    
}
