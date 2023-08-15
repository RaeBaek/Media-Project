//
//  CreditTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/15.
//

import UIKit

class CreditTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 10
        profileImageView.contentMode = .scaleToFill
        
        nameLabel.font = .systemFont(ofSize: 17, weight: .medium)
        nameLabel.textColor = .black
        
        characterLabel.font = .systemFont(ofSize: 15, weight: .regular)
        characterLabel.textColor = .darkGray
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
