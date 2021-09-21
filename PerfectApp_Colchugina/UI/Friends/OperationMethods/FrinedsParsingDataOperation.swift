//
//  FrinedsParsingDataOperation.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 21.09.2021.
//

import Foundation

final class FrinedsParsingDataOperation: Operation {
    
    //MARK:- Private properties
    private var list: FriendsResponse?
    
    //MARK:- Public methods
    override func main() {
        guard let friendsData = dependencies.first as? FrinedsMakeApiDataOperation,
              let data = friendsData.getData()
        else {return}
        do {
            let json = try JSONDecoder().decode(FriendsResponse.self, from: data)
            list = json
        }
        catch {
            print(error)
        }
    }
    
    func getFrindsList() -> FriendsResponse? {
        return list
    }
    
}
