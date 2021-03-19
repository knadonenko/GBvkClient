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
        let sourceId = newsItem.source_id
        let newsAuthor = groups.first(where: { $0.id == abs(sourceId) })?.name ?? ""

        cell.loadData(newsItem, newsAuthor)

        return cell
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
            getNews()
            isLoading = false
        }
        
    }
}
