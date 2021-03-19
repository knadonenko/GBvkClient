//
//  Attachments.swift
//  VKClient
//
//  Created by Константин Надоненко on 21.02.2021.
//

import Foundation
import RealmSwift

class Attachment: Decodable {
    @objc dynamic var type: String = ""
    var photo: Photo?
    
    enum CodingKeys: String, CodingKey {
        case type
        case photo
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try values.decode(String.self, forKey: .type)
        self.photo = try values.decodeIfPresent(Photo.self, forKey: .photo)
    }
}

class Photo: Decodable {
    var sizes: List<Size>?

    enum CodingKeys: String, CodingKey {
        case sizes
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.sizes = try values.decode(List<Size>.self, forKey: .sizes)
    }
}
