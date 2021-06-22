//
//  CustomFriendsNavigationController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 30.05.2021.
//

import UIKit

class CustomFriendsNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PushSliderAnimator()
        } else if operation == .pop {
            return PopSliderAnimator()
        }
        return nil
    }
}

extension CustomFriendsNavigationController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopSliderAnimator()
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushSliderAnimator()
    }
}


