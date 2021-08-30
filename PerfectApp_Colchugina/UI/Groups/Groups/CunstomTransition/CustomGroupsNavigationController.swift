//
//  CustomGroupsNavigationController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 30.05.2021.
//

import UIKit

class CustomGroupsNavigationController: UINavigationController, UINavigationControllerDelegate {

    let interactiveTransition = CustomGroupsInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            if operation == .push {
                self.interactiveTransition.viewController = toVC
                return PushZoomAnimator()
            } else if operation == .pop {
                if navigationController.viewControllers.first != toVC {
                    self.interactiveTransition.viewController = toVC
                }
                return PopZoomAnimator()
            }
            return nil
    }
}

extension CustomGroupsNavigationController: UIViewControllerTransitioningDelegate {

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopZoomAnimator()
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushZoomAnimator()
    }
}

