//
//  PopSliderAnimator.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 30.05.2021.
//

import UIKit

class PopSliderAnimator: NSObject, UIViewControllerAnimatedTransitioning  {
    
    private let duration: TimeInterval = 0.6
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let source = transitionContext.viewController(forKey: .from)!
        let destination = transitionContext.viewController(forKey: .to)!
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        
        destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(rotationAngle: .pi/2)
        
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.frame = transitionContext.containerView.frame
        
        UIView.animate(
            withDuration: duration,
            animations: {
                source.view.transform = CGAffineTransform(rotationAngle: -.pi/1.1)
                destination.view.transform = .identity
            },
            completion: {(isComplition) in
                if transitionContext.transitionWasCancelled {
                    source.view.transform = .identity
                }
                transitionContext.completeTransition(isComplition && !transitionContext.transitionWasCancelled)
                
            })
        
    }
}


