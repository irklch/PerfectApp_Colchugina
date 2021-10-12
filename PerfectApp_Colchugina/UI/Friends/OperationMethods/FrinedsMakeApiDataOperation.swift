//
//  FrinedsMakeApiDataOperation.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 21.09.2021.
//

import Foundation

final class FrinedsMakeApiDataOperation: Operation {
    
    //MARK: - Private properties
    private var data: Data?
    
    //MARK: - Public methods
    override func main() {
        guard let url = URL(string: URLs.friendsList) else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        self.data = data
    }

    func getData() -> Data? {
        return data
    }
    
}
