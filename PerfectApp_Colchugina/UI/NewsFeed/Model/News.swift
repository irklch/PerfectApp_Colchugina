//
//  NewsFeedList.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 13.05.2021.
//

import Foundation
import RealmSwift


class News {
    var postId = 0
    var groupName = ""
    var groupPhoto = ""
    var profileName: String?
    var profilePhoto: String?
    var newsText = ""
    var date = TimeInterval()
    var attachments = ""
    var attachmentHeight = 0
    var attachmentWidth = 0
    var comments = 0
    var likes = 0
    var isLiked = false
    var reposts = 0
    var views = 0
    var nextFrom = ""
    var isTappedShowMore = false


    convenience init(postId: Int,
                     groupName: String,
                     groupPhoto: String,
                     profileName: String,
                     profilePhoto: String,
                     newsText: String,
                     date: TimeInterval,
                     attachments: String,
                     attachmentHeight: Int,
                     attachmentWidth: Int,
                     comments: Int,
                     likes: Int,
                     reposts: Int,
                     views: Int,
                     nextFrom: String) {
        self.init()
        self.postId = postId
        self.groupName = groupName
        self.groupPhoto = groupPhoto
        self.profileName = profileName
        self.profilePhoto = profilePhoto
        self.newsText = newsText
        self.date = date
        self.attachments = attachments
        self.attachmentHeight = attachmentHeight
        self.attachmentWidth = attachmentWidth
        self.comments = comments
        self.likes = likes
        self.reposts = reposts
        self.views = views
        self.nextFrom = nextFrom

    }
}

