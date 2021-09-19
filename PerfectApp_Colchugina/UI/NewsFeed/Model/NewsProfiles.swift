//
//  NewsProfiles.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 18.09.2021.
//

import Foundation

struct NewsResponseProfiles: Decodable {
    let response: NewsResponseProfilesList
}

struct NewsResponseProfilesList: Decodable {
    let profiles: [NewsProfiles]
}

struct NewsProfiles: Decodable {
    var id: Int
    var first_name: String
    var last_name: String
    var photo_100: String
}
