//
//  FirebaseLoader.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 29.08.2021.
//

import Foundation
import Firebase

final class FirebaseLoader {
    
    static func saveLoggedUser(groups: [GroupsForFirebase]) {
        let ref = Database.database(url: FirebaseDatabaseInfo.url).reference(withPath: FirebaseDatabaseInfo.name)
        let groupsToSend = groups
            .map { $0.toFirestore() }
        ref.child(Session.shared.id).setValue(groupsToSend)
    }
}


