//
//  GroupModel.swift
//  VKClient
//
//  Created by Константин Надоненко on 24.12.2020.
//

import Foundation

class GroupResponse: Decodable {
    let response: GResponse
}

class GResponse: Decodable {
    let items: [GroupModel]
}

class GroupModel: Decodable {
    
    var name: String?
    var photo_50: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo_50
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.photo_50 = try values.decodeIfPresent(String.self, forKey: .photo_50) ?? ""
    }
    
}
