//
//  OverviewTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/15.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        overviewLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
