//
//  GroupModel.swift
//  VKClient
//
//  Created by Константин Надоненко on 24.12.2020.
//

import Foundation
import RealmSwift

class GroupResponse: Decodable {
    let response: GResponse
}

class GResponse: Decodable {
    let items: [GroupModel]
}

class GroupModel: Object, Decodable {
    
    @objc dynamic var id = 0
    @objc dynamic var name: String?
    @objc dynamic var photo_50: String?
    @objc dynamic var date = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo_50
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.photo_50 = try values.decodeIfPresent(String.self, forKey: .photo_50) ?? ""
    }
    
}
