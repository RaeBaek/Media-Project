//
//  CreditTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/13.
//

import UIKit

class CreditTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var departmentLabel: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 5
        
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        genderLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        departmentLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        popularityLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        characterLabel.numberOfLines = 0
        characterLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
