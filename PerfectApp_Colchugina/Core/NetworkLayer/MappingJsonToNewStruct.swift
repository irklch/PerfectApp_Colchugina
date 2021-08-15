//
//  MappingJsonToNewStruct.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 12.08.2021.
//

import Foundation

class MappingJson {
    func createNewFriendStruct (oldStruct: [FriendsList]) -> [Friends] {
        var newStruct = [Friends](repeating: .init(firstName: "",
                                                   lastName: "",
                                                   photo: "",
                                                   id: 0),
                                  count: oldStruct.count)
        for item in 0..<oldStruct.count {
            newStruct[item].firstName = oldStruct[item].first_name
            newStruct[item].lastName = oldStruct[item].last_name
            newStruct[item].photo = oldStruct[item].photo_200_orig
            newStruct[item].id = oldStruct[item].id
        }
        return newStruct
    }

    func createNewPhotoStruct (oldStruct: [PhotosSizes]) -> [PhotosFriend] {
        var newStruct = [PhotosFriend](repeating: .init(url: ""),
                                       count: oldStruct.count)
        for item in 0..<oldStruct.count {
            if let photo = oldStruct[item].sizes.last {
                newStruct[item].url = String(photo.url)
            }
        }
        return newStruct
    }

    func createNewGoupsStruct (oldStruct: [GroupsList]) -> [Groups] {
        var newStruct = [Groups](repeating: .init(name: "",
                                                  photo: ""),
                                 count: oldStruct.count)
        for item in 0..<oldStruct.count {
            newStruct[item].name = oldStruct[item].name
            newStruct[item].photo = oldStruct[item].photo_200
        }
        return newStruct
    }
}
