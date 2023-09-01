//
//  AvatarImageView.swift
//  Media Project
//
//  Created by 백래훈 on 2023/09/01.
//

import UIKit

class AvatarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubview", frame.width, frame)
        layer.cornerRadius = frame.width / 2
    }
    
}

