//
//  TabBarController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet var accountTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        accountTabBar.tintColor = UIColor.brandYellow
        switch overrideUserInterfaceStyle{
        case .dark:
            accountTabBar.unselectedItemTintColor = UIColor.white
        case .light:
            accountTabBar.unselectedItemTintColor = UIColor.black
        default:
            return
        }
        
    }
}
