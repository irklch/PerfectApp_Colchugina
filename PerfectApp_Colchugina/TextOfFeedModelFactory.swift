//
//  TextOfFeedModelFactory.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 04.11.2021.
//

import UIKit
import Kingfisher

final class NewsCellViewModel {
    var textOfFeedLabel = NSMutableAttributedString()
    var authorPhotoImageView = URL(string: "")
    var authorNameLable = ""
    var dateOfPublicationLabel = ""
    var photoOfFeedImageView = URL(string: "")
    var likeButton = 0
    var commentButton = 0
    var shareButton = 0
    var viewsButton = 0
    var isLiked = false
}

enum TextOfFeedModelFactory {
    static func makeViewModels(from news: [News]) -> [NewsCellViewModel] {
        return news.map(makeViewModel)
    }

    static func makeViewModel(from news: News) -> NewsCellViewModel {
        let cell = NewsCellViewModel()
        //author
        let trueDate = Date(timeIntervalSince1970: news.date)

        cell.authorNameLable = news.profileName ?? news.groupName
        guard let url = URL(string: news.profilePhoto ?? news.groupPhoto) else {return NewsCellViewModel()}
        cell.authorPhotoImageView = url
        cell.dateOfPublicationLabel = dateFormatter.string(from: trueDate)

        //text
        if news.newsText.count > 200 && news.newsText != "" {
            if news.isTappedShowMore {
                let newString = news.newsText + " Show Less"
                let lessString = "Show Less"
                let range = (newString as NSString).range(of: lessString)
                let mutableAttributedString = NSMutableAttributedString.init(string: String(newString))
                mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
                cell.textOfFeedLabel = mutableAttributedString
            } else {
                let droppedString = news.newsText.dropLast(news.newsText.count - 200) + "... Show More"
                let moreString = "Show More"
                let range = (droppedString as NSString).range(of: moreString)
                let mutableAttributedString = NSMutableAttributedString.init(string: String(droppedString))
                mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
                cell.textOfFeedLabel = mutableAttributedString
            }
        }
        else {
            let mutableAttributedString = NSMutableAttributedString.init(string: news.newsText)
            cell.textOfFeedLabel = mutableAttributedString
        }

        //photo
        guard let url = URL(string: news.attachments) else {return NewsCellViewModel()}
        cell.photoOfFeedImageView = url

        //likes
        cell.likeButton = news.likes
        cell.commentButton = news.comments
        cell.shareButton = news.reposts
        cell.viewsButton = news.views
        cell.isLiked = news.isLiked
        return cell
    }
    
    static var dateFormatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter
    }
}
