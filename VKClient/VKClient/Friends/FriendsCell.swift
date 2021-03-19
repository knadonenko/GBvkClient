//
//  FriendsCell.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit
import SDWebImage

class FriendsCell: UITableViewCell {
    
    @IBOutlet weak var friendsName: UILabel!
    @IBOutlet weak var friendsAvatar: UIImageView! 
    @IBOutlet weak var roundedView: RoundedAvatar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setFriendsData(friend: FriendsModel) {
        friendsName.text = "\(friend.first_name!) \(friend.last_name!)"
        friendsAvatar.sd_setImage(with: URL(string: friend.photo_50 ?? ""), placeholderImage: UIImage(named: "friend01"))
    }
    
}
