//
//  Session.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 05.08.2021.
//

import Foundation

final class Session {
    var id = ""
    var token = ""
    static var shared = Session()
    private init () {}
}
