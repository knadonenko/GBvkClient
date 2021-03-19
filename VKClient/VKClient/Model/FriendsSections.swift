//
// Created by Константин Надоненко on 17.01.2021.
//

import Foundation

struct FriendsSections {
    var letter : String = ""
    var names : [FriendsModel] = []

    mutating func mapToSection(_ friends: [FriendsModel]) -> [FriendsSections] {
        let groupedFriends = Dictionary(grouping: friends.sorted(), by: {String($0.first_name!.prefix(1))})
        let keys = groupedFriends.keys.sorted()

        return keys.map{ FriendsSections(letter: $0, names: groupedFriends[$0]!.sorted())}
    }

}
