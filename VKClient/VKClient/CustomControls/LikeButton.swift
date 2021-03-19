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

    var owner_id = 0
    var post_id = 0

    let session = Session.shared
    let network = NetworkRequests()

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
        likeButtonView.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        UIView.transition(with: likeLabel,
                duration: 0.25,
                options: .transitionFlipFromLeft,
                animations: { self.likeLabel.text = "\(self.likeCounter)" },
                completion: nil)
    }

    func decrementLikesCount() {
        likeCounter -= 1
        UIView.transition(with: likeLabel,
                duration: 0.25,
                options: .transitionFlipFromRight,
                animations: { self.likeLabel.text = "\(self.likeCounter)" },
                completion: nil)
    }
    
    public func updateLikeButton() {
        isLike = true
        likeButtonView.setImage(UIImage(named: "liked"), for: .normal)
    }

    public func updateLikesCount(likes: Int) {
        likeCounter = likes
        likeLabel.text = "\(likes)"
    }

    public func isLiked() -> Bool {
        return isLike
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
        makeLikeRequest();
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

    func makeLikeRequest() {
        var likes = ""
        if isLiked() == true {
            likes = "add"
        } else {
            likes = "delete"
        }
        network.likes(session.token, postOwner: String(owner_id), String(post_id), likes)
    }

}
