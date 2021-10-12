//
//  FrinedsSortDataOnSectionsOperation.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 21.09.2021.
//

import Foundation

final class FrinedsSortDataOnSectionsOperation: Operation {

    //MARK: - Private methods
    private let vc: FriendsTableViewController

    //MARK: - Initialization
    init(viewController: FriendsTableViewController) {
        self.vc = viewController
    }


//    MARK: - Public method
    override func main() {
        guard let friendsData = dependencies.first as? FrinedsLoadAndPairRealmOperation else {return}
        var friendsSortedList = [[Friends]]()
        var friendsList = friendsData.getFriendsList()
        friendsList.sort { $0.lastName < $1.lastName }
        let lettersLists = Array(Set(friendsList.map({ String($0.lastName.first ?? "*") }))).sorted()

        lettersLists.forEach { letter in
            let friends = friendsList.filter({String($0.lastName.first ?? "*") == letter})
            friendsSortedList.append(friends)
        }
        vc.addFriendsSortedList(friendsSortLists: friendsSortedList, lettersLists: lettersLists)
    }

}
