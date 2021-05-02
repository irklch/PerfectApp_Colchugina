//
//  FriendsNavigationController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit

class FriendsNavigationController: UINavigationController {

    @IBOutlet var tapBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch overrideUserInterfaceStyle{
        case .dark:
            tapBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
            self.navigationItem.backBarButtonItem?.tintColor = .white
        case .light:
            tapBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
            self.navigationItem.backBarButtonItem?.tintColor = .black
        default:
            return
        }
        
    }
    

}
