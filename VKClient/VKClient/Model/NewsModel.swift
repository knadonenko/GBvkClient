//
//  NewsModel.swift
//  VKClient
//
//  Created by Константин Надоненко on 11.02.2021.
//

import Foundation

class NewsResponse: Decodable {
    let response: NResponse
}

class NResponse: Decodable {
    let items: [NewsModel]
    let groups: [GroupModel]
}

class NewsModel: Decodable {
    
    @objc dynamic var source_id = 0
    @objc dynamic var text: String?
    var attachments: [Attachment]?
    var comments: Reactions?
    var likes: Reactions?
    var reposts: Reactions?
    var views: Reactions?
    var post_id = 0

    enum CodingKeys: String, CodingKey {
        case source_id
        case text
        case attachments
        case comments
        case likes
        case reposts
        case views
        case post_id
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.source_id = try values.decode(Int.self, forKey: .source_id)
        self.text = try values.decodeIfPresent(String.self, forKey: .text) ?? ""
        self.attachments = try values.decodeIfPresent([Attachment].self, forKey: .attachments)
        self.comments = try values.decodeIfPresent(Reactions.self, forKey: .comments)
        self.likes = try values.decodeIfPresent(Reactions.self, forKey: .likes)
        self.reposts = try values.decodeIfPresent(Reactions.self, forKey: .reposts)
        self.views = try values.decodeIfPresent(Reactions.self, forKey: .views)
        self.post_id = try values.decode(Int.self, forKey: .post_id)
    }

}
