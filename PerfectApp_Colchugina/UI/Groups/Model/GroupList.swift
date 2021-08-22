//
//  GroupList.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import Foundation

//MARK:- Public properties

struct GroupsResponse: Decodable {
    let response: GroupsItems
}

struct GroupsItems: Decodable {
    let items: [GroupsList]
}

struct GroupsList: Decodable {
    var name: String
    var photo_200: String
}

struct Groups {
    var name = ""
    var photo = ""
}


