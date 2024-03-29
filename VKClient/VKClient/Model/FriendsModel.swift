//
//  FriendsModel.swift
//  VKClient
//
//  Created by Константин Надоненко on 24.12.2020.
//

import Foundation
import RealmSwift

class FriendsResponse: Decodable {
    let response: FResponse
}

class FResponse: Decodable {
    let items: [FriendsModel]
}

class FriendsModel: Object, Decodable, Comparable {

    @objc dynamic var first_name: String?
    @objc dynamic var id = 0
    @objc dynamic var last_name: String?
    @objc dynamic var photo_50: String?
    @objc dynamic var date = ""
    
    enum CodingKeys: String, CodingKey {
        case first_name
        case id
        case last_name
        case photo_50
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.first_name = try values.decode(String.self, forKey: .first_name)
        self.id = try values.decode(Int.self, forKey: .id)
        self.last_name = try values.decode(String.self, forKey: .last_name)
        self.photo_50 = try values.decode(String.self, forKey: .photo_50)
    }
    
    static func < (lhs: FriendsModel, rhs: FriendsModel) -> Bool {
        lhs.first_name! < rhs.first_name!
    }
    
}
