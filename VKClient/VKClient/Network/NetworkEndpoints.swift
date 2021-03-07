//
//  NetworkEndpoints.swift
//  VKClient
//
//  Created by Константин Надоненко on 07.03.2021.
//

import Foundation

enum NetworkEndpoints: String {
    case FRIENDS_URL = "friends.get"
    case PERSONAL_PHOTO_URL = "photos.get"
    case GROUPS_URL = "groups.get"
    case GROUPS_SEARCH_URL = "groups.search"
    case NEWSFEED_URL = "newsfeed.get"
    case LIKES_ADD = "likes.add"
    case LIKES_DELETE = "likes.delete"
}
