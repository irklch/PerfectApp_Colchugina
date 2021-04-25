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
        tapBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        self.navigationItem.backBarButtonItem?.tintColor = .black
    }
    

}
