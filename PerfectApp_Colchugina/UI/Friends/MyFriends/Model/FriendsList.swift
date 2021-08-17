//
//  FriendsList.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import Foundation
import RealmSwift

//MARK:- Public properties

struct FriendsResponse: Decodable {
    let response: FriendsItems
}

struct FriendsItems: Decodable {
    let items: [FriendsList]
}

struct FriendsList: Decodable {
    var id: Int
    var first_name: String
    var last_name: String
    var photo_200_orig: String
}

class Friends: RealmSwift.Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var id: Int = 0

    convenience init(firstName: String, lastName: String, photo: String, id: Int) {
        self.init()

        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.id = id
    }
}


