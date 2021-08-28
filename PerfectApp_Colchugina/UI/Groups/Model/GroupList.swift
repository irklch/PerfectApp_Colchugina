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
    var id: Int
    var name: String
    var photo_200: String
}

class Groups: RealmSwift.Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String = ""

    convenience init(id: Int, name: String, photo: String) {
        self.init()
        self.id = id
        self.name = name
        self.photo = photo
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}


