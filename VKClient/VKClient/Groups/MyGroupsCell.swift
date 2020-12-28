//
//  MyGroupsCell.swift
//  VKClient
//
//  Created by Константин Надоненко on 04.11.2020.
//

import UIKit

class MyGroupsCell: UITableViewCell {
    
    @IBOutlet weak var myGroupPhoto: UIImageView!
    @IBOutlet weak var myGroupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
