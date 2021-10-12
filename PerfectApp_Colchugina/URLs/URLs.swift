//
//  .swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 11.08.2021.
//

import Foundation

final class URLs {

    static func vkAuth () -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7730758"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "state", value: "12345"),
            URLQueryItem(name: "scope", value: "wall,friends"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        return urlComponents.url
    }
    static let friendsList = "https://api.vk.com/method/friends.get?user_id=\(Session.shared.id)&access_token=\(Session.shared.token)&order=name&fields=nickname,photo_200_orig&v=5.126"
    
    static func friendsPhotoList (idFriend text: String) -> String {
        return "https://api.vk.com/method/photos.get?user_id=\(text)&access_token=\(Session.shared.token)&album_id=profile&v=5.126"
    }
    
    static let groupList = "https://api.vk.com/method/groups.get?user_id=\(Session.shared.id)&access_token=\(Session.shared.token)&extended=1&v=5.131"
    
    static func newsList (startTime: TimeInterval? = nil, startFrom: String? = nil) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.id)"),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "max_photos", value: "1"),
            URLQueryItem(name: "source_ids", value: "groups"),
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        if startTime != nil {
            urlComponents.queryItems?.append(
                URLQueryItem(name: "start_time", value: "\(startTime ?? 0)")
            )
        }

        if startFrom != nil {
            urlComponents.queryItems?.append(
                URLQueryItem(name: "start_from", value: "\(startFrom ?? "")")
            )
        }
        return urlComponents.url
    }
}
