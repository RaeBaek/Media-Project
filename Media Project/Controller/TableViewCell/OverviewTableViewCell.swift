//
//  OverviewTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/15.
//

import UIKit

class OverviewTableViewCell: BaseTableViewCell {
    
    let overviewLabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    override func configureCell() {
        contentView.addSubview(overviewLabel)
    }
    
    override func setConstraints() {
        overviewLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
