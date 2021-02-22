//
//  NewsTableViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 15.11.2020.
//

import UIKit
import SDWebImage

class NewsTableViewController: UITableViewController {
    
    var newsFeed: [NewsModel] = []
    var groups: [GroupModel] = []
    
    let session = Session.shared
    let network = NetworkRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.getNewsFeed(session.token) { [weak self] newsFeed, groups in
            self?.newsFeed = newsFeed
            self?.groups = groups
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsFeed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCellTableViewCell
        
        let newsItem = newsFeed[indexPath.row]
        
        let newsTitle = newsItem.text
        let sourceId = newsItem.source_id
        let newsAuthor = groups.first(where: {$0.id == abs(sourceId)})?.name
        
        if newsItem.attachments![0].type == "photo" {
            let imageURL = newsItem.attachments![0].photo?.sizes?.first(where: {
                $0.height > 300
            })?.url
            cell.newsImage.isHidden = false
            cell.newsImage.sd_setImage(with: URL(string: imageURL ?? ""), placeholderImage: UIImage(named: "city"))
        } else {
            cell.newsImage.isHidden = true
        }
        
        cell.newsTitle.text = newsAuthor ?? ""
        cell.newsText.text = newsTitle
        
        let commentsCount = newsItem.comments?.count
        let likeCount = newsItem.likes?.count
        let repostCount = newsItem.reposts?.count
        
        cell.commentsCount.text = String(commentsCount!)
        cell.repostsCount.text = String(likeCount!)
        cell.viewsCount.text = String(repostCount!)
        
        return cell
    }
    
}
