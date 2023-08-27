//
//  CheckUIView.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/25.
//

import UIKit

class CheckUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        clipsToBounds = true
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubview", frame.width, frame)
        layer.cornerRadius = frame.width / 2
    }
}
