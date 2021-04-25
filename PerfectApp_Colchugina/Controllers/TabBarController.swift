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
        accountTabBar.tintColor = UIColor(red: 0.972, green: 0.845, blue: 0.286, alpha: 1.0)
        accountTabBar.unselectedItemTintColor = UIColor.black
    }
}
