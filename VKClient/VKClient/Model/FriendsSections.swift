//
// Created by Константин Надоненко on 17.01.2021.
//

import Foundation

struct FriendsSections {
    var letter : String = ""
    var names : [String] = []

    mutating func mapToSection(_ friends: [FriendsModel]) -> [FriendsSections] {
        var namesList: [String] = [];
        friends.forEach {
            namesList.append("\($0.first_name!) \($0.last_name!)")
        }
        let groupedFriends = Dictionary(grouping: namesList.sorted(), by: {String($0.prefix(1))})
        let keys = groupedFriends.keys.sorted()

        return keys.map{ FriendsSections(letter: $0, names: groupedFriends[$0]!.sorted())}
    }

}