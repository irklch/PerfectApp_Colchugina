//
//  TabBarController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet var newTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        newTabBar.tintColor = UIColor.yellow
        newTabBar.barTintColor = UIColor.red
        newTabBar.unselectedItemTintColor = UIColor.blue
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
