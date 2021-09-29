//
//  FrinedsLoadAndPairRealmOperation.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 21.09.2021.
//

import Foundation
import RealmSwift

final class FrinedsLoadAndPairRealmOperation: Operation {

    //MARK:- Private properties
    private let vc: FriendsTableViewController
    private var friendsList = [Friends]()
    private var realmToken: NotificationToken?

    //MARK:- Initialization
    init(viewController: FriendsTableViewController) {
        self.vc = viewController
    }

    //MARK:- Public methods
    override func main() {
        let friendsRealmLists: Results<Friends>?
        do {
            let realm = try Realm()
            
            let friendsData = realm.objects(Friends.self)
            friendsRealmLists = friendsData
            guard let items = friendsRealmLists else {return}
            items.forEach { item in
                friendsList.append(item)
            }
        } catch {
            print(error)
        }
        vc.addFriendsList(list: friendsList)
    }

    func getFriendsList() -> [Friends] {
        return friendsList
    }

}
