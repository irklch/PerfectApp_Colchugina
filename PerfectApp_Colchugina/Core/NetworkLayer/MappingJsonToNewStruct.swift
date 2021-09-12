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
            let friend = Friends()
            friend.firstName = jsonItem.first_name
            friend.lastName = jsonItem.last_name
            friend.photo = jsonItem.photo_200_orig
            friend.id = jsonItem.id
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

    func savePhotos (jsonItems: [PhotosSizes]) {
        var photosList = [PhotosFriend]()
        jsonItems.forEach { jsonItem in
            if let jsonPhoto = jsonItem.sizes.last {
                let photo = PhotosFriend()
                photo.url = jsonPhoto.url
                photosList.append(photo)
            }
        }
        do {
            let realm = try Realm()
            realm.beginWrite()
            let oldPhotos = realm.objects(PhotosFriend.self)
            realm.delete(oldPhotos)
            realm.add(photosList)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func saveGroups (jsonItems: [GroupsList]) {
        var groupsList = [Groups]()
        jsonItems.forEach { jsonItem in
            let group = Groups()
            group.name = jsonItem.name
            group.photo = jsonItem.photo_200
            group.id = jsonItem.id
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
