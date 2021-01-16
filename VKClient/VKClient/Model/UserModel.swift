//
//  UserModel.swift
//  VKClient
//
//  Created by Константин Надоненко on 28.12.2020.
//

import Foundation
import RealmSwift

class UserResponse: Decodable {
    let response: UserItems
}

class UserItems: Decodable {
    let items: [User]
}

class User: Decodable {
    let sizes: [Size]

    init(sizes: [Size]) {
        self.sizes = sizes
    }
}

class Size: Object, Codable {
    @objc dynamic let url: String

    init(url: String) {
        self.url = url
    }
}
