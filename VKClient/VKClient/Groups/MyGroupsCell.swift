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

    func configure(with viewModel: GroupViewModel) {
        myGroupName.text = viewModel.name
        myGroupPhoto.sd_setImage(with: URL(string: viewModel.photo_50))
    }

}
