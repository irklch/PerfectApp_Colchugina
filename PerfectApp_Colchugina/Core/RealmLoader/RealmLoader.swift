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

    func savePhotos (jsonItems: [PhotosSizes]) {
        var photosList = [PhotosFriend]()
        jsonItems.forEach { jsonItem in
            if let jsonPhoto = jsonItem.sizes.last {
                let photo = PhotosFriend(url: jsonPhoto.url)
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
        saveGroupsInFirebase(jsonItems: jsonItems)
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

    private func saveGroupsInFirebase(jsonItems: [GroupsList]) {
        var groupsList = [GroupsForFirebase]()
        jsonItems.forEach { jsonItem in
            let group = GroupsForFirebase(id: jsonItem.id,
                                          name: jsonItem.name,
                                          photo: jsonItem.photo_200)
            groupsList.append(group)
        }
        FirebaseLoader.saveLoggedUser(groups: groupsList)
    }
    
}
