//
//  DottedProgressBar.swift
//  VKClient
//
//  Created by Константин Надоненко on 15.11.2020.
//

import UIKit

class DottedProgressBar: UIView {
    
    var circleLayer1 = UIView()
    var circleLayer2 = UIView()
    var circleLayer3 = UIView()
    
    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    func setupView() {
        circleLayer1.layer.addSublayer(setupImageViews())
        circleLayer2.layer.addSublayer(setupImageViews())
        circleLayer3.layer.addSublayer(setupImageViews())
        stackView = UIStackView(arrangedSubviews: [circleLayer1, circleLayer2, circleLayer3])
        self.addSubview(stackView)
        stackView.distribution = .fillEqually
    }
    
    func setupImageViews() -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.backgroundColor = UIColor.gray.cgColor
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        circleLayer.position = CGPoint(x: 40, y: 20)
        circleLayer.cornerRadius = 10
        return circleLayer
    }
    
    func animate() {
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.repeat]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.circleLayer1.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.circleLayer2.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.circleLayer3.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.circleLayer1.alpha = 1
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.circleLayer2.alpha = 1
            }

            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.25) {
                self.circleLayer3.alpha = 1
            }
        }
    }
    
}
