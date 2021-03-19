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
}

class NewsModel: Decodable {
    
    @objc dynamic var text: String?

    enum CodingKeys: String, CodingKey {
        case text
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try values.decodeIfPresent(String.self, forKey: .text) ?? ""
    }
    
}
