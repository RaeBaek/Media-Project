//
//  ProfileImageTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/09/01.
//

import UIKit

class ProfileImageTableViewCell: BaseTableViewCell {
    
    let profileImage = {
        let view = ProfileImageView(frame: .zero)
        view.image = UIImage(named: "프로필사진")
        return view
    }()
    
    let abatarImage = {
        let view = AvatarImageView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    let editLabel = {
        let view = UILabel()
        view.text = "사진 또는 아바타 수정"
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.textColor = .systemBlue
        return view
    }()
    
    override func configureCell() {
        super.configureCell()
        
        [profileImage, abatarImage, editLabel].forEach {
            contentView.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        profileImage.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(0.7)
            $0.centerY.equalToSuperview().multipliedBy(0.85)
            $0.size.equalTo(90)
        }
        
        abatarImage.snp.makeConstraints {
            $0.centerX.equalToSuperview().multipliedBy(1.3)
            $0.centerY.equalToSuperview().multipliedBy(0.85)
            $0.size.equalTo(90)
        }
        
        editLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
        
    }
}

