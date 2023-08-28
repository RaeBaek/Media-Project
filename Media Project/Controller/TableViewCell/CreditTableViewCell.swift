//
//  CreditTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/15.
//

import UIKit

class CreditTableViewCell: BaseTableViewCell {
    
    
    let profileImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.contentMode = .scaleToFill
        return view
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    let characterLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    override func configureCell() {
        [profileImageView, nameLabel, characterLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.width.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView).multipliedBy(0.8)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        characterLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView).multipliedBy(1.2)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
    
}
