//
//  AppDelegate.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 23.04.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configurationFirebase()
        return true
    }
    
    private func configurationFirebase() {
        FirebaseApp.configure()
    }

}

