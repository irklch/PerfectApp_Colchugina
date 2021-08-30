//
//  LoggedUser.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 29.08.2021.
//

import Foundation
import Firebase

final class LoggedUser {
    let id: String
    let ref: DatabaseReference?

    init(id: String) {
        self.ref = nil
        self.id = id
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? String else {
                return nil
        }

        self.ref = snapshot.ref
        self.id = id
    }

    func toAnyObject() -> [String: Any] {
        return [
            "id": id
        ]
    }
}

