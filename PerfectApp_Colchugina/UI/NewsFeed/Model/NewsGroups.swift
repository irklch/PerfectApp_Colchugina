//
//  NewsGroups.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 18.09.2021.
//

import Foundation

struct NewsResponseGroups: Decodable {
    let response: NewsResponseGroupsList
}

struct NewsResponseGroupsList: Decodable {
    let groups: [NewsGroups]
}

struct NewsGroups: Decodable {
    var id: Int
    var name: String
    var photo_200: String
}
