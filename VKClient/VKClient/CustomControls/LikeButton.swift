//
//  LikeButton.swift
//  VKClient
//
//  Created by Константин Надоненко on 08.11.2020.
//

import UIKit

@IBDesignable class LikeButton: UIControl {
    
    let likeButtonView = UIButton()
    let likeLabel = UILabel()
    var stackView: UIStackView!
    var likeCounter: Int = 0
    var isLike: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    func setupView() {
        likeButtonView.setImage(UIImage(named: "unliked"), for: .normal)
        likeLabel.text = "\(likeCounter)"
        likeLabel.textColor = UIColor.darkGray
        
        stackView = UIStackView(arrangedSubviews: [likeButtonView, likeLabel])
        self.addSubview(stackView)
        stackView.distribution = .fillEqually
        likeButtonView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    func incrementLikesCount() {
        likeCounter += 1
        updateLikesCount(likes: likeCounter)
    }
    
    func decrementLikesCount() {
        likeCounter -= 1
        updateLikesCount(likes: likeCounter)
    }
    
    func updateLikesCount(likes: Int) {
        likeLabel.text = "\(likes)"
    }
    
    func like() {
        if !isLike {
            likeButtonView.setImage(UIImage(named: "liked"), for: .normal)
            incrementLikesCount()
            isLike = true
        } else {
            likeButtonView.setImage(UIImage(named: "unliked"), for: .normal)
            decrementLikesCount()
            isLike = false
        }
    }
    
    @objc func onTap(_ sender: UIButton) {
        like()
    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap(_:)))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
}
