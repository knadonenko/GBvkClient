//
//  Reactions.swift
//  VKClient
//
//  Created by Константин Надоненко on 22.02.2021.
//

import Foundation

class Reactions: Decodable {
    
    var count: Int = 0
    var user_likes: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case count
        case user_likes
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decode(Int.self, forKey: .count)
        self.user_likes = try values.decodeIfPresent(Int.self, forKey: .user_likes) ?? 0
    }
    
}
