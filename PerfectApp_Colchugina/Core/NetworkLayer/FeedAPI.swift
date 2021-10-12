//
//  FeedAPI.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 11.10.2021.
//

import Foundation

final class FeedAPI {
    func getFeed(startTime: TimeInterval? = nil, startFrom: String? = nil, completion: @escaping ([News]) -> ()) {
        var newsList = [News]()
        let saving = RealmLoader()
        let dispatchGroup = DispatchGroup()
        var itemsResponse = [NewsItems]()
        var groupsResponse = [NewsGroups]()
        var profileResponse = [NewsProfiles]()
        var nextFromPosts: NewsNextFromPosts?
    guard let url = URLs.newsList(startTime: startTime, startFrom: startFrom) else {return}
        let session = URLSession.shared
        DispatchQueue.global(qos: .userInitiated).async(group: dispatchGroup) {
            session.dataTask(with: url) { (data, request, error) in

                if let error = error {
                    print(error)
                }
                if let data = data {
                    do {
                        let jsonItems = try JSONDecoder().decode(NewsResponseItems.self, from: data)
                        itemsResponse = jsonItems.response.items
                        let jsonGroups = try JSONDecoder().decode(NewsResponseGroups.self, from: data)
                        groupsResponse = jsonGroups.response.groups
                        let jsonProfiles = try JSONDecoder().decode(NewsResponseProfiles.self, from: data)
                        profileResponse = jsonProfiles.response.profiles
                        let jsonNext = try JSONDecoder().decode(NewsResponseNextFrom.self, from: data)
                        nextFromPosts = jsonNext.response
                    }
                    catch {
                        print(error)
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    newsList = saving.saveNews(jsonItems: itemsResponse,
                                               jsonGroups: groupsResponse,
                                               jsonProfiles: profileResponse,
                                               jsonNextFrom: nextFromPosts)
                    completion(newsList)
                }
            }.resume()
        }
    }
}
