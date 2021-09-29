//
//  NewsFeedList.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 13.05.2021.
//

import Foundation
import RealmSwift


class News: Object {
    @objc dynamic var postId = 0
    @objc dynamic var groupName = ""
    @objc dynamic var groupPhoto = ""
    @objc dynamic var profileName: String?
    @objc dynamic var profilePhoto: String?
    @objc dynamic var newsText = ""
    @objc dynamic var date = 0
    @objc dynamic var attachments = ""
    @objc dynamic var comments = 0
    @objc dynamic var likes = 0
    @objc dynamic var reposts = 0
    @objc dynamic var views = 0

    convenience init(postId: Int,
                     groupName: String,
                     groupPhoto: String,
                     profileName: String,
                     profilePhoto: String,
                     newsText: String,
                     date: Int,
                     attachments: String,
                     comments: Int,
                     likes: Int,
                     reposts: Int,
                     views: Int) {
        self.init()
        self.postId = postId
        self.groupName = groupName
        self.groupPhoto = groupPhoto
        self.profileName = profileName
        self.profilePhoto = profilePhoto
        self.newsText = newsText
        self.date = date
        self.attachments = attachments
        self.comments = comments
        self.likes = likes
        self.reposts = reposts
        self.views = views
    }
    override class func primaryKey() -> String? {
        return "postId"
    }
}

