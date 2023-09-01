//
//  ProfileTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/09/01.
//

import UIKit

class ProfileTableViewCell: BaseTableViewCell {
    
    let titleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17, weight: .regular)
        view.textColor = .black
        return view
    }()
    
    let titleTextField = {
        let view = UITextField()
        view.font = .systemFont(ofSize: 17, weight: .regular)
        view.textColor = .black
        view.borderStyle = .none
        view.isEnabled = false
        return view
    }()
    
    let nextImage = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.tintColor = .lightGray
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func configureCell() {
        super.configureCell()
        
        [titleLabel, titleTextField, nextImage].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(100)
        }
        
        nextImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(15)
        }
        
        titleTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16)
            $0.trailing.equalTo(nextImage.snp.leading).offset(-16)
        }
        
    }
}
