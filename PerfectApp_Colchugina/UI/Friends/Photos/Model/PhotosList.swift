//
//  PhotosList.swift.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 11.08.2021.
//

import Foundation
import RealmSwift

//MARK:- Public properties

struct PhotosResponse: Decodable {
    let response: PhotosItems
}
struct PhotosItems: Decodable {
    let items: [PhotosSizes]
}

struct PhotosSizes: Decodable {
    let sizes: [PhotosUrl]
}

struct PhotosUrl: Decodable {
    var url: String
}

class PhotosFriend: Object {
    @objc dynamic var url = ""

    convenience init (url: String) {
        self.init()

        self.url = url
    }
}
