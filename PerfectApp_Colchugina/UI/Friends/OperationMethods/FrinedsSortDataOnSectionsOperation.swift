//
//  FrinedsSortDataOnSectionsOperation.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 21.09.2021.
//

import Foundation

final class FrinedsSortDataOnSectionsOperation: Operation {
    
    //MARK:- Private methods
    private let vc: FriendsTableViewController
    private var friendsLists = [Friends]()
    private var friendsSortLists = [[Friends]]()
    private var friendsReseveLists = [[Friends]]()
    private var lettersLists = [String]()
    private var lettersSortReserveLists = [String]()
    
    //MARK:- Initialization
    init(viewController: FriendsTableViewController) {
        self.vc = viewController
    }
    
    //MARK:- Public method
    override func main() {
        guard let friendsData = dependencies.first as? FrinedsLoadAndPairRealmOperation else {return}
        var friendsList = friendsData.getFriendsList()
        friendsList.sort { $0.lastName < $1.lastName }
        lettersLists = Array(Set(friendsList.map({ String($0.lastName.first ?? "*") }))).sorted()
        lettersLists.forEach { letter in
            let friend = sortFriendBySection(letter, friendsList)
            friendsSortLists.append(friend)
        }
        friendsReseveLists = friendsSortLists
        lettersSortReserveLists = lettersLists
        vc.addSortedLists(friendsSortLists: friendsSortLists, friendsReseveLists: friendsReseveLists, lettersLists: lettersLists, lettersSortReserveLists: lettersSortReserveLists)
    }
    
    //MARK:- Private method
    private func sortFriendBySection (_ letter: String, _ arr: [Friends]) -> [Friends] {
        return arr.filter { String($0.lastName.first ?? "*") == letter }
    }
    
}
