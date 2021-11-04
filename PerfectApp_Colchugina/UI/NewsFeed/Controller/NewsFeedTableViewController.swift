//
//  NewsFeedTableViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 13.05.2021.
//

import UIKit
import RealmSwift

class NewsFeedTableViewController: UITableViewController {
    private var nextFrom = ""
    private var newsList = [News]()
    private var viewModel = [NewsCellViewModel]()
    private var isLoading = false
    private let feedApi = FeedAPI()
    private var expandableTextRange: NSRange?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        setViews()
        downloadJson()
        setupToRefreshConstrol()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel[indexPath.section]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorOfFeedTableViewCell.reuseId, for: indexPath) as! AuthorOfFeedTableViewCell
            cell.config(from: item)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextOfFeedTableViewCell.reuseId, for: indexPath) as! TextOfFeedTableViewCell
            cell.config(from: item)
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoOfFeedTableViewCell.reuseId) as! PhotoOfFeedTableViewCell
            cell.config(from: item)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: LikeCountTableViewCell.reuseId) as! LikeCountTableViewCell
            cell.config(from: item, with: indexPath.section)
            cell.selectionStyle = .none
            cell.likeButton.addTarget(self, action: #selector(tapToLike), for: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = newsList[indexPath.section]
        switch indexPath.row {
        case 1:
            if item.isTappedShowMore {
                item.isTappedShowMore = false
            } else {
                item.isTappedShowMore = true
            }
            tableView.reloadData()
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        func currentPhotoHeight(_ item: News) -> CGFloat {
            let height = item.attachmentHeight
            let width = item.attachmentWidth
            guard height != 0 else {return UITableView.automaticDimension}
            guard width != 0 else {return UITableView.automaticDimension}
            let tableWidth = tableView.bounds.width
            let aspectRatio = CGFloat(height) / CGFloat(width)
            let cellHeight = tableWidth * aspectRatio
            return cellHeight
        }
        let currentFeedItem = newsList[indexPath.section]
        switch indexPath.row {
        case 2:
            return currentPhotoHeight(currentFeedItem)
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    //MARK: - Private methods
    
    @objc
    private func tapToLike(_ button: UIButton) {
        if newsList[button.tag].isLiked {
            newsList[button.tag].isLiked = false
            newsList[button.tag].likes -= 1
            tableView.reloadData()
        } else {
            newsList[button.tag].isLiked = true
            newsList[button.tag].likes += 1
            tableView.reloadData()
        }
    }
    
    private func setupToRefreshConstrol() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl?.tintColor = .red
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    @objc
    func refreshNews() {
        self.refreshControl?.beginRefreshing()
        let mostFreshNewsDate = self.newsList.first?.date ?? Date().timeIntervalSince1970
        feedApi.getFeed(startTime: mostFreshNewsDate+1) { [weak self] result in
            guard let self = self else {return}
            self.refreshControl?.endRefreshing()
            guard  result.count > 0 else {return}
            self.newsList = result + self.newsList
            let indexSet = IndexSet(integersIn: 0..<result.count)
            self.tableView.insertSections(indexSet, with: .automatic)
        }
    }
    
    private func downloadJson() {
        feedApi.getFeed { result in
            self.newsList = result
            self.viewModel = TextOfFeedModelFactory.makeViewModels(from: result)
            self.nextFrom = result.first?.nextFrom ?? ""
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setViews() {
        tableView.register(AuthorOfFeedTableViewCell.self, forCellReuseIdentifier: AuthorOfFeedTableViewCell.reuseId)
        tableView.register(TextOfFeedTableViewCell.self, forCellReuseIdentifier: TextOfFeedTableViewCell.reuseId)
        tableView.register(PhotoOfFeedTableViewCell.self, forCellReuseIdentifier: PhotoOfFeedTableViewCell.reuseId)
        tableView.register(LikeCountTableViewCell.self, forCellReuseIdentifier: LikeCountTableViewCell.reuseId)
    }
}

extension NewsFeedTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({$0.section}).max() else {return}
        if maxSection > newsList.count - 3,
           !isLoading {
            isLoading = true
            feedApi.getFeed(startFrom: nextFrom) { [weak self] result in
                guard let self = self else { return }
                guard  result.count > 0 else {return}
                let indexSet = IndexSet(integersIn: self.newsList.count..<self.newsList.count + result.count)
                self.newsList.append(contentsOf: result)
                self.nextFrom = result.first?.nextFrom ?? ""
                self.tableView.insertSections(indexSet, with: .automatic)
                self.isLoading = false
            }
        }
    }
    
}
