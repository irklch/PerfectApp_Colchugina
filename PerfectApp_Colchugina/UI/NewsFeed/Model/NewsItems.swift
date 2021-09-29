//
//  NewsItems.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 18.09.2021.
//

import Foundation

struct NewsResponseItems: Decodable {
    let response: NewsResponseItemsList
}

struct NewsResponseItemsList: Decodable {
    let items: [NewsItems]
}

struct NewsItems: Decodable {
    var source_id: Int
    var date: Int
    var text: String
    var signer_id: Int?
    let attachments: [NewsAttachments]?
    let comments: NewsCommentsCount
    let likes: NewsLikesCount
    let reposts: NewsRepostsCount
    let views: NewsViewsCount?
    var post_id: Int
}

struct NewsAttachments: Decodable {
    var photo: NewsAttachmentsListPhoto?
    var video: NewsAttachmentsListVideo?
}

struct NewsAttachmentsListPhoto: Decodable {
    let sizes: [NewsAttachmentsListPhotoSizes]
}

struct NewsAttachmentsListPhotoSizes: Decodable {
    var url: String
}

struct NewsAttachmentsListVideo: Decodable {
    let first_frame: [NewsAttachmentsListVideoFirstName]?
}

struct NewsAttachmentsListVideoFirstName: Decodable {
    var url: String
}

struct NewsCommentsCount: Decodable {
    var count: Int
}

struct NewsLikesCount: Decodable {
    var count: Int
}

struct NewsRepostsCount: Decodable {
    var count: Int
}

struct NewsViewsCount: Decodable {
    var count: Int
}
