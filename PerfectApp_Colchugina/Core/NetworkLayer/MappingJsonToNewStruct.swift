//
//  MappingJsonToNewStruct.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 12.08.2021.
//

import Foundation
import RealmSwift

class MappingJson {
    func createNewFriendStruct (oldStruct: [FriendsList]) {
        var newStruct = [Friends]()
        oldStruct.forEach { friend in
            let itemFriend = Friends()
            itemFriend.firstName = friend.first_name
            itemFriend.lastName = friend.last_name
            itemFriend.photo = friend.photo_200_orig
            itemFriend.id = friend.id
            newStruct.append(itemFriend)
        }
        do {
            let realm = try Realm()
            realm.beginWrite()
            let oldFriends = realm.objects(Friends.self)
            realm.delete(oldFriends)
            realm.add(newStruct)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func createNewPhotoStruct (oldStruct: [PhotosSizes]) {
        var newStruct = [PhotosFriend]()
        oldStruct.forEach { photo in
            if let oldPhoto = photo.sizes.last {
                let itemPhoto = PhotosFriend()
                itemPhoto.url = oldPhoto.url
                newStruct.append(itemPhoto)
            }
        }
        do {
            let realm = try Realm()
            realm.beginWrite()
            let oldFriends = realm.objects(PhotosFriend.self)
            realm.delete(oldFriends)
            realm.add(newStruct)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func createNewGoupsStruct (oldStruct: [GroupsList]) {
        var newStruct = [Groups]()
        oldStruct.forEach { group in
            let itemGroup = Groups()
            itemGroup.name = group.name
            itemGroup.photo = group.photo_200
            newStruct.append(itemGroup)
        }
        do {
            let realm = try Realm()
            realm.beginWrite()
            let oldFriends = realm.objects(Groups.self)
            realm.delete(oldFriends)
            realm.add(newStruct)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
}
