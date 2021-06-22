//
//  Session.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 22.06.2021.
//

import Foundation

class Session {
    static var shared = Session()
    
    private init() {}
    
    var token: String?
    var id: Int?

}
