//
//  Session.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 22.06.2021.
//

import Foundation

final class Session {
    var id: Int?
    var token: String?
    static var shared = Session()
    
    private init() {}
    
    var token: String?
    var id: Int?

}
