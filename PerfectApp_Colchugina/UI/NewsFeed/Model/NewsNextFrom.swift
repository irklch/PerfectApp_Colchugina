//
//  NewsNextFrom.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 11.10.2021.
//

import Foundation

struct NewsResponseNextFrom: Decodable {
    let response: NewsNextFromPosts
}

struct NewsNextFromPosts: Decodable {
    let next_from: String?
}
