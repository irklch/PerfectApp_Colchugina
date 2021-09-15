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
}
