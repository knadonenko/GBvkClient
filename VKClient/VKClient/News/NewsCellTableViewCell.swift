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
    @IBOutlet weak var showMoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func loadData(_ newsItem: NewsModel, _ newsAuthor: String) {

        newsTitle.text = newsAuthor
        
        let newsItemText = newsItem.text ?? ""
        
        if newsItemText.count > 200 {
            showMoreButton.isHidden = false
            newsText.numberOfLines = 5
        }
        
        newsText.text = newsItem.text

        let commentsCounter = newsItem.comments?.count
        let likeCounter = newsItem.likes?.count
        let repostCounter = newsItem.reposts?.count
        let viewsCounter = newsItem.views?.count ?? 0
        
        if newsItem.likes?.user_likes == 1 {
            likeButton.updateLikeButton()
        }

        likeButton.updateLikesCount(likes: Int(likeCounter!))
        commentsCount.text = String(commentsCounter!)
        repostsCount.text = String(repostCounter!)
        viewsCount.text = String(viewsCounter)

        likeButton.owner_id = newsItem.source_id
        likeButton.post_id = newsItem.post_id
        
        showPhoto(with: newsItem)
    }
    
    @IBAction func showMoreButtonClicked(_ sender: UIButton) {
        
        newsText.numberOfLines = 0
        showMoreButton.isHidden = true
        
    }
    
    func showPhoto(with newsData: NewsModel) {
        if let newsAttachments = newsData.attachments?[0] {
            if newsAttachments.type == "photo" {
                let imageURL = newsAttachments.photo?.sizes?.first(where: {
                    $0.height > 300
                })?.url
                newsImage.isHidden = false
                newsImage.sd_setImage(with: URL(string: imageURL ?? ""), placeholderImage: UIImage(named: "city"))
            } else {
                newsImage.isHidden = true
            }
        }
    }

}
