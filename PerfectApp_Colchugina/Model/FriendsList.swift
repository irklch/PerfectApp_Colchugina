//
//  FriendsList.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import Foundation

class Friends {
    
    struct AllInfo {
        var name: String
        var photo: [String]
    }
    
    static var list = [
        AllInfo.init(name: "Иван Иванов", photo: ["иван1","иван2","иван3","иван4"]),
        AllInfo.init(name: "Пётр Петров", photo: ["петр1","петр2","петр3","петр4"]),
        AllInfo.init(name: "Алексей Алексеев", photo: ["алексей1","алексей2","алексей3"]),
        AllInfo.init(name: "Ирина Иринова", photo: ["ирина1","ирина2","ирина3"]),
        AllInfo.init(name: "Александра Александрова", photo: ["александра1","александра2","александра3"]),
        AllInfo.init(name: "Екатерина Екатеринова", photo: ["екатерина1","екатерина2","екатерина3"]),
        AllInfo.init(name: "Дмитрий Дмитриев", photo: ["дмитрий1","дмитрий2","дмитрий3"])
    ]
    
}


