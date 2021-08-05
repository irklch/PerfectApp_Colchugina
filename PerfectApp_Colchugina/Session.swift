//
//  Session.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 05.08.2021.
//

import Foundation

final class Session {
    private static var shared = Session()
    private var id: Int?
    private var token: String?
    private init() {}
}

