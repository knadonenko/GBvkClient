//
//  FriendsCell.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit

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
    
    func setFriendsData(text: String) {
        friendsName.text = text
//        friendsAvatar = UIImage(named: friendsList[section.names[indexPath.row]]!)
    }
    
}
