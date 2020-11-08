//
//  AlphabeticView.swift
//  VKClient
//
//  Created by Константин Надоненко on 08.11.2020.
//

import UIKit

@IBDesignable class AlphabeticView: UIControl {
    
    let charLabel = UILabel()
    var stackView: UIStackView!
    var char = "a"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        charLabel.textColor = UIColor.white
        self.backgroundColor = UIColor.darkGray
        stackView = UIStackView(arrangedSubviews: [charLabel])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }

}
