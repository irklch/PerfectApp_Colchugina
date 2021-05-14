//
//  NewsFeedTableViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 13.05.2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    @IBOutlet var groupIconImageView: UIImageView!
    @IBOutlet var groupNameLable: UILabel!
    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var newsTextLabel: UILabel!
    @IBOutlet var newsImageView: UIImageView!
    
    var isToggled: Bool = false
    
    static var reuseId = "NewsFeedTableViewCell"
    
    func config (_ groupName: String, _ groupPhoto: String, _ title: String, _ text: String, _ image: String, _ likeCount: Int, _ commentCount: Int, _ shareCount: Int, _ viewCount: Int) {
        groupIconImageView.layer.cornerRadius = CGFloat(20)
        groupNameLable.text = groupName
        groupIconImageView.image = UIImage(named: groupPhoto)
        newsTitleLabel.text = title
        newsTextLabel.text = text
        newsImageView.image = UIImage(named: image)

//        feed.likeCountLabel.text = "10"
//        feed.commentCountLabel.text = "\(commentCount)"
//        feed.shareCountLabel.text = "\(commentCount)"
//        feed.viewCountLabel.text = "\(viewCount)"
       
        
    }
   
    
}
