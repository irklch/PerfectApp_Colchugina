//
//  GroupsNavigationController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit

class GroupsNavigationController: UINavigationController {
    
    @IBOutlet var tapBarItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    }
    

 

}
