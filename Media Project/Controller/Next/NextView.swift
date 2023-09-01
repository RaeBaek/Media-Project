//
//  NextView.swift
//  Media Project
//
//  Created by 백래훈 on 2023/09/01.
//

import UIKit

class NextView: BaseView {
    
    let titleLabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.init(251), for: .horizontal)
        view.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        view.font = .systemFont(ofSize: 17, weight: .medium)
        view.textColor = .black
        return view
    }()
    
    let textField = {
        let view = UITextField()
        view.setContentHuggingPriority(.init(250), for: .horizontal)
        view.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        view.font = .systemFont(ofSize: 17, weight: .regular)
        return view
    }()
    
    let lineView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func configureView() {
        super.configureView()
        
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(lineView)
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
        }
        
        textField.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(35)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
}

