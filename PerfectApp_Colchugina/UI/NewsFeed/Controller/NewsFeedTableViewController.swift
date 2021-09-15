//
//  NewsFeedTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 13.05.2021.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return NewsFeed.list.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = NewsFeed.list[indexPath.section]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorOfFeedTableViewCell.reuseId, for: indexPath) as! AuthorOfFeedTableViewCell
            cell.config(authorName: item.groupName, authorPhoto: item.groupIcon, dateOfPublication: Date())
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextOfFeedTableViewCell.reuseId, for: indexPath) as! TextOfFeedTableViewCell
            cell.config(textOfFeed: item.newsText)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoOfFeedTableViewCell.reuseId) as! PhotoOfFeedTableViewCell
            cell.config(photoOfFeed: item.newsImage)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: LikeCountTableViewCell.reuseId) as! LikeCountTableViewCell
            cell.config(likeCount: Int.random(in: 0...100), commentCount: Int.random(in: 0...100), shareCount: Int.random(in: 0...100), viewsCont: Int.random(in: 0...100))
            cell.selectionStyle = .none
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToLike(_:)))
            cell.likeButton.addGestureRecognizer(tapGesture)
            return cell
        default:
            return UITableViewCell() 
        }
    }
    
    //MARK:- Private methods
    @objc
    private func tapToLike(_ button: UIButton) {
        if button.tintColor != .red {
            button.setImage(UIImage.init(systemName: "suit.heart.fill"), for: .normal)
            let count = Int(button.titleLabel?.text ?? "0") ?? 0 + 1
            button.setTitle("\(count)", for: .selected)
            button.tintColor = .red
        } else {
            button.setImage(UIImage.init(systemName: "suit.heart"), for: .normal)
            button.tintColor = .systemGray
            let count = Int(button.titleLabel?.text ?? "0") ?? 0 - 1
            button.setTitle("\(count)", for: .normal)
        }
    }
    
    private func setViews() {
        tableView.register(AuthorOfFeedTableViewCell.self, forCellReuseIdentifier: AuthorOfFeedTableViewCell.reuseId)
        tableView.register(TextOfFeedTableViewCell.self, forCellReuseIdentifier: TextOfFeedTableViewCell.reuseId)
        tableView.register(PhotoOfFeedTableViewCell.self, forCellReuseIdentifier: PhotoOfFeedTableViewCell.reuseId)
        tableView.register(LikeCountTableViewCell.self, forCellReuseIdentifier: LikeCountTableViewCell.reuseId)
    }
    
}
