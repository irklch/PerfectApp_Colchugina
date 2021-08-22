//
//  .swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 11.08.2021.
//

import Foundation

final class URLs {
    static let friendsList = "https://api.vk.com/method/friends.get?user_id=\(Session.shared.id)&access_token=\(Session.shared.token)&order=name&fields=nickname,photo_200_orig&v=5.126"
    
    static func friendsPhotoList (idFriend text: String) -> String {
        return "https://api.vk.com/method/photos.get?user_id=\(text)&access_token=\(Session.shared.token)&album_id=profile&v=5.126"
    }
    
    static let groupList = "https://api.vk.com/method/groups.get?user_id=\(Session.shared.id)&access_token=\(Session.shared.token)&extended=1&v=5.131"
    
    func groupListFromSearch (searchText text: String) -> String {
        return "https://api.vk.com/method/friends.get?access_token=\(Session.shared.token)&q=\(text)&v=5.126"
    }
}
