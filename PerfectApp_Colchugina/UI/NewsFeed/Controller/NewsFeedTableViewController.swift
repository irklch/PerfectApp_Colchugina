//
//  NewsFeedTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 13.05.2021.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NewsFeed.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.reuseId, for: indexPath) as! NewsFeedTableViewCell
        let item = NewsFeed.list[indexPath.row]
        cell.config(item.groupName, item.groupIcon, item.newsTitle, item.newsText, item.newsImage)
        cell.feedControl.config(item.likeCount, item.commentCount, item.shareCount, item.viewCount, indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    

}
