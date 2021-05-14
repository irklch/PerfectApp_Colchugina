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
        
        return News.list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.reuseId, for: indexPath) as! NewsFeedTableViewCell
        let item = News.list[indexPath.row]
        cell.config(item.groupName, item.groupIcon, item.newsTitle, item.newsText, item.newsImage, item.likeCount, item.commentCount, item.shareCount, item.viewCount)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
    }
    
    
}
