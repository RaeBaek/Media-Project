//
//  OverviewButtonTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/16.
//

import UIKit

class OverviewButtonTableViewCell: UITableViewCell {

    @IBOutlet var openOverviewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        openOverviewImage.tintColor = .darkGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
