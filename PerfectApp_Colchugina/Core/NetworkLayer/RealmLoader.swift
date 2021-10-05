//
//  MappingJsonToNewStruct.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 12.08.2021.
//

import Foundation
import RealmSwift

class RealmLoader {
    func saveFriends (jsonItems: [FriendsList]) {
        var friendsList = [Friends]()
        jsonItems.forEach { jsonItem in
            let friend = Friends(firstName: jsonItem.first_name,
                                 lastName: jsonItem.last_name,
                                 photo: jsonItem.photo_200_orig,
                                 id: jsonItem.id)
            friendsList.append(friend)
        }
        do {
            let realm = try Realm()
            
            realm.beginWrite()
            realm.add(friendsList, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func savePhotos (idFriend: Int, jsonItems: [PhotosSizes]) {
        var photosList = [PhotosFriend]()
        jsonItems.forEach { jsonItem in
            if let jsonPhoto = jsonItem.sizes.last {
                let photo = PhotosFriend(id: idFriend, url: jsonPhoto.url)
                photosList.append(photo)
            }
        }
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photosList, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func saveGroups (jsonItems: [GroupsList]) {
        var groupsList = [Groups]()
        jsonItems.forEach { jsonItem in
            let group = Groups(id: jsonItem.id,
                               name: jsonItem.name,
                               photo: jsonItem.photo_200)
            groupsList.append(group)
        }
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groupsList, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func saveNews (jsonItems: [NewsItems], jsonGroups: [NewsGroups], jsonProfiles: [NewsProfiles]){
        var newsList = [News]()
        jsonItems.forEach { jsonItem in
            let news = News()
            news.postId = jsonItem.post_id
            for i in 0..<jsonGroups.count {
                if abs(jsonItem.source_id) == jsonGroups[i].id {
                    news.groupName = jsonGroups[i].name
                    news.groupPhoto = jsonGroups[i].photo_200
                }
            }
            for i in 0..<jsonProfiles.count {
                if abs(jsonItem.signer_id ?? 0) == jsonProfiles[i].id {
                    news.profileName = "\(jsonProfiles[i].first_name) \(jsonProfiles[i].last_name)"
                    news.profilePhoto = jsonProfiles[i].photo_100
                }
            }
            news.date = jsonItem.date
            news.newsText = jsonItem.text
            news.attachments = jsonItem.attachments?.last?.photo?.sizes.last?.url ?? jsonItem.attachments?.last?.video?.first_frame?.last?.url ?? ""
            news.comments = jsonItem.comments.count
            news.likes = jsonItem.likes.count
            news.reposts = jsonItem.reposts.count
            news.views = jsonItem.reposts.count
            newsList.append(news)
        }
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(newsList, update: .modified)
            
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
