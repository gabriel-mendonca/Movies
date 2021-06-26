//
//  UINavigationController.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 05/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class TransitionNavigationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var popStyle: Bool = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.50
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if popStyle {
            
            animatedPop(using: transitionContext)
            return
        }
        
            let fz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let tz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!

            let f = transitionContext.finalFrame(for: tz)

            let fOOF = f.offsetBy(dx: f.width, dy: 55)
            tz.view.frame = fOOF
            transitionContext.containerView.insertSubview(tz.view, aboveSubview: fz.view)

            UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                tz.view.frame = f
            } completion: { (_) in
                transitionContext.completeTransition(true)
            }
    }
    
    func animatedPop(using transitionContext: UIViewControllerContextTransitioning) {
        let fz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let tz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let f = transitionContext.initialFrame(for: fz)
        let fOOFpop = f.offsetBy(dx: f.width, dy: 55)
        
        transitionContext.containerView.insertSubview(tz.view, belowSubview: fz.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            fz.view.frame = fOOFpop
        } completion: { (_) in
            transitionContext.completeTransition(true)
        }

    }

}
