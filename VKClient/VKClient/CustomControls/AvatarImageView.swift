//
//  AvatarImageView.swift
//  VKClient
//
//  Created by Константин Надоненко on 07.11.2020.
//

import UIKit

class AvatarImageView: UIImageView {

    override func layoutSubviews() {
            super.layoutSubviews()
            self.layer.borderWidth = 2.0
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = self.frame.size.width / 2
            self.contentMode = .scaleAspectFit
            self.clipsToBounds = true
    }

}
