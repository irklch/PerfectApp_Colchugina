//
//  FriendsList.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import Foundation

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

struct Friends {
    var firstName = ""
    var lastName = ""
    var photo = ""
    var id = 0
}
