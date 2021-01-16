//
//  CustomPushAnimation.swift
//  VKClient
//
//  Created by Константин Надоненко on 24.11.2020.
//

import UIKit

class CustomPushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        
        transitionContext.containerView.backgroundColor = .white

        let translation = CGAffineTransform(translationX: 500, y: source.view.frame.width)
        let rotate = CGAffineTransform(rotationAngle: -CGFloat(Double.pi/2))

        destination.view.transform = translation.concatenating(rotate)
        
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 1,
                                                       animations: {
                                                        let tranlation = CGAffineTransform(translationX: -source.view.frame.width / 2, y: source.view.frame.width)
                                                        let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                                                        source.view.transform = tranlation.concatenating(rotation)
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                       relativeDuration: 1,
                                                       animations: {
                                                        let tranlation = CGAffineTransform(translationX: 0, y: 0)
                                                        let rotation = CGAffineTransform(rotationAngle: 0)
                                                        destination.view.transform = tranlation.concatenating(rotation)
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        destination.view.transform = .identity
                                                       })
                                }, completion: { finished in
                                    if finished && !transitionContext.transitionWasCancelled {
                                        source.view.transform = .identity
                                    }
                                    transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
                                })
        
    }
    
}
