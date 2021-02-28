//
//  NewsCellTableViewCell.swift
//  VKClient
//
//  Created by Константин Надоненко on 15.11.2020.
//

import UIKit

class NewsCellTableViewCell: UITableViewCell {
        
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var repostsCount: UILabel!
    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet weak var likeButton: LikeButton!

    let session = Session.shared
    let network = NetworkRequests()

    var newsFeed: NewsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



}
