//
//  NewsFeedTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 13.05.2021.
//

import UIKit
import RealmSwift

class NewsFeedTableViewController: UITableViewController {
    var newsList = [News]()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        downloadJson()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = newsList[indexPath.section]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorOfFeedTableViewCell.reuseId, for: indexPath) as! AuthorOfFeedTableViewCell
            cell.config(authorName: item.profileName ?? item.groupName, authorPhoto: item.profilePhoto ?? item.groupPhoto, dateOfPublication: item.date)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextOfFeedTableViewCell.reuseId, for: indexPath) as! TextOfFeedTableViewCell
            cell.config(textOfFeed: item.newsText)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoOfFeedTableViewCell.reuseId) as! PhotoOfFeedTableViewCell
            cell.config(photoOfFeed: item.attachments)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: LikeCountTableViewCell.reuseId) as! LikeCountTableViewCell
            cell.config(likeCount: item.likes, commentCount: item.comments, shareCount: item.reposts, viewsCont: item.views)
            cell.selectionStyle = .none
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToLike(_:)))
            cell.likeButton.addGestureRecognizer(tapGesture)
            return cell
        default:
            return UITableViewCell()
        }
    }

    //MARK:- Private methods

    private func downloadJson() {
        let dispatchGroup = DispatchGroup()
        var itemsResponse = [NewsItems]()
        var groupsResponse = [NewsGroups]()
        var profileResponse = [NewsProfiles]()
        let saving = RealmLoader()
        guard let url = URL(string: URLs.newsList) else {return}
        let session = URLSession.shared
        DispatchQueue.global(qos: .userInitiated).async(group: dispatchGroup) {
            session.dataTask(with: url) { (data, request, error) in

                if let error = error {
                    print(error)
                }
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(NewsResponseItems.self, from: data)
                        itemsResponse = json.response.items
                    }
                    catch {
                        print(error)
                    }
                }
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(NewsResponseGroups.self, from: data)
                        groupsResponse = json.response.groups

                    }
                    catch {
                        print(error)
                    }
                }
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(NewsResponseProfiles.self, from: data)
                        profileResponse = json.response.profiles

                    }
                    catch {
                        print(error)
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    saving.saveNews(jsonItems: itemsResponse, jsonGroups: groupsResponse, jsonProfiles: profileResponse)
                    self.readRealm()
                    self.tableView.reloadData()
                }
            }.resume()
        }
    }

    private func readRealm() {
        let newsRealmLists: Results<News>?
        do {
            let realm = try Realm()
            let newsData = realm.objects(News.self)
            newsRealmLists = newsData
            guard let items = newsRealmLists else {return}
            items.forEach { item in
                newsList.append(item)
            }
        } catch {
            print(error)
        }
    }

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
