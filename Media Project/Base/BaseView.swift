//
//  BaseView.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/28.
//

import UIKit
import SnapKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = .systemBackground
    }
    
    func setConstraints() { }
}
