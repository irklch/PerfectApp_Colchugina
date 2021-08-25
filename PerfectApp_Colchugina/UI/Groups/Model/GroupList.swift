//
//  GroupList.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import Foundation
import RealmSwift

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

class Groups: Object {
    @objc dynamic var name = ""
    @objc dynamic var photo = ""

    convenience init(name: String, photo: String) {
        self.init()

        self.name = name
        self.photo = photo
    }
}


