//
//  APIRequests.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 06.08.2021.
//

import Foundation
protocol VKRequestsProtocol: AnyObject{
    func getFriendList(completion: @escaping(Result<FriendsResponse, Error>) -> Void)
    func getFriendsPhotoList(idFriend: String, completion: @escaping(Result<PhotosResponse, Error>) -> Void)
    func getGroupList (completion: @escaping(Result<GroupsResponse, Error>) -> Void)
}

final class VKRequests {

    private func downloadJson<T: Decodable>(url: String, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared

        session.dataTask(with: url) { (data, request, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(json))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

extension VKRequests: VKRequestsProtocol {
    func getFriendList(completion: @escaping(Result<FriendsResponse, Error>) -> Void) {
        downloadJson(url: URLs.friendsList, completion: completion)
    }
    func getFriendsPhotoList(idFriend: String, completion: @escaping(Result<PhotosResponse, Error>) -> Void) {
        downloadJson(url: URLs.friendsPhotoList(idFriend: idFriend), completion: completion)
    }
    func getGroupList (completion: @escaping(Result<GroupsResponse, Error>) -> Void) {
        downloadJson(url: URLs.groupList, completion: completion)
    }
}
