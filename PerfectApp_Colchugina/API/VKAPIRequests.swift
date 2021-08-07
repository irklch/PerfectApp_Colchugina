//
//  APIRequests.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 06.08.2021.
//

import Foundation

class VKRequests {

    func getFriendList() {

        guard let url = URL(string: "https://api.vk.com/method/friends.get?user_id=\(Session.shared.id)&access_token=\(Session.shared.token)&order=name&fields=nickname&v=5.126") else {return}
        print (Session.shared.id)
        print (Session.shared.token)

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) { (data, response, error) in

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    //print abrakadabra instead of first_names and last_name
//                    print(json)

                    guard let jsonString = NSString(data: data as Data,
                                                    encoding: String.Encoding.utf8.rawValue) as String? else {return}
                    // print utf8
//                    print(jsonString)


                }
                catch {
                    print (error)
                }
            }

        }
        task.resume()

    }

    func getFriendsPhotoList() {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?user_id=\(Session.shared.id)&access_token=\(Session.shared.token)&order=name&fields=nickname,photo_200_orig&v=5.126") else {return}

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
//                    print(json)

                    guard let jsonString = NSString(data: data,
                                                    encoding: String.Encoding.utf8.rawValue) as String? else {return}
//                    print(jsonString)
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()

    }

    func getGroupList() {

        guard let url = URL(string:"https://api.vk.com/method/groups.get?user_id=\(Session.shared.id)&access_token=\(Session.shared.token)&extended=1&v=5.131") else {return}

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
//                    print (json)

                    guard let jsonString =
                            NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? else {return}
//                    print (jsonString)
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()


    }


    func getGroupListFromSearch(groupName name: String) {
        guard let url = URL(
                string: "https://api.vk.com/method/friends.get?access_token=\(Session.shared.token)&q=\(name)&v=5.126")
        else {return}
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
//                    print (json)

                    guard let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String?
                    else {return}
//                    print (jsonString)
                }
                catch {
                    print(error)
                }
            }

        }
        task.resume()
    }


}
