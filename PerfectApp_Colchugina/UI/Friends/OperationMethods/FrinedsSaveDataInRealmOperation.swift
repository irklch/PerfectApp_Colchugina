//
//  FrinedsSaveDataInRealmOperation.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 21.09.2021.
//

import Foundation

final class FrinedsSaveDataInRealmOperation: Operation {

    //MARK:- Public method
    override func main() {
        guard let friendsData = dependencies.first as? FrinedsParsingDataOperation,
              let friendsList = friendsData.getFrindsList()?.response.items
        else {return}

        let mapping = RealmLoader()
        mapping.saveFriends(jsonItems: friendsList)
    }
    
}
