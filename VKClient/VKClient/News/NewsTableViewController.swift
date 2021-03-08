//
//  NewsTableViewController.swift
//  VKClient
//
//  Created by Константин Надоненко on 15.11.2020.
//

import UIKit
import SDWebImage
import PromiseKit

class NewsTableViewController: UITableViewController {

    var newsFeed: [NewsModel] = []
    var groups: [GroupModel] = []

    let session = Session.shared
    let network = NetworkRequests()
    
    var nextFrom = ""
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        pullToRefresh()
        getNews()

        tableView.prefetchDataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCellTableViewCell

        let newsItem = newsFeed[indexPath.row]

        let newsTitle = newsItem.text
        let sourceId = newsItem.source_id
        let newsAuthor = groups.first(where: { $0.id == abs(sourceId) })?.name

        showPhoto(cell, with: newsItem)

        cell.newsTitle.text = newsAuthor ?? ""
        cell.newsText.text = newsTitle

        let commentsCount = newsItem.comments?.count
        let likeCount = newsItem.likes?.count
        let repostCount = newsItem.reposts?.count
        let viewsCount = newsItem.views?.count ?? 0
        
        if newsItem.likes?.user_likes == 1 {
            cell.likeButton.updateLikeButton()
        }

        cell.likeButton.updateLikesCount(likes: Int(likeCount!))
        cell.commentsCount.text = String(commentsCount!)
        cell.repostsCount.text = String(repostCount!)
        cell.viewsCount.text = String(viewsCount)

        cell.likeButton.owner_id = newsItem.source_id
        cell.likeButton.post_id = newsItem.post_id

        return cell
    }
    
    func showPhoto(_ cell: NewsCellTableViewCell, with newsData: NewsModel) {
        if let newsAttachments = newsData.attachments?[0] {
            if newsAttachments.type == "photo" {
                let imageURL = newsAttachments.photo?.sizes?.first(where: {
                    $0.height > 300
                })?.url
                cell.newsImage.isHidden = false
                cell.newsImage.sd_setImage(with: URL(string: imageURL ?? ""), placeholderImage: UIImage(named: "city"))
            } else {
                cell.newsImage.isHidden = true
            }
        }
    }
    
    func getNews() {
        firstly {
            network.getNews(session.token, nextFrom)
        }.done { data in
            self.newsFeed.append(contentsOf: try! JSONDecoder().decode(NewsResponse.self, from: data).response.items)
            self.groups.append(contentsOf: try! JSONDecoder().decode(NewsResponse.self, from: data).response.groups)
            self.nextFrom = try! JSONDecoder().decode(NewsResponse.self, from: data).response.next_from
            self.tableView.reloadData()
        }.catch { error in
            print(error)
        }
    }
    
    fileprivate func pullToRefresh() {
        
        refreshControl = UIRefreshControl()
        
        refreshControl?.attributedTitle = NSAttributedString(string: "Обновляем ленту")
        refreshControl?.tintColor = .blue
        
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
    }
    
    @objc func refreshNews() {
        self.refreshControl?.beginRefreshing()
        nextFrom = ""
        newsFeed = []
        groups = []
        getNews()
        self.refreshControl?.endRefreshing()
    }
    
}

extension NewsTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.row }).max() else {
            return
        }
        if maxSection > newsFeed.count - 4, !isLoading {
            isLoading = true
            print("111111111111 LOADING")
            getNews()
            isLoading = false
        }
        
    }
}
