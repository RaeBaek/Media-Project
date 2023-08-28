//
//  OverviewButtonTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/16.
//

import UIKit

class OverviewButtonTableViewCell: BaseTableViewCell {

//    @IBOutlet var openOverviewImage: UIImageView!
    
    let openOverviewImage = {
        let view = UIImageView()
        view.tintColor = .darkGray
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func configureCell() {
        contentView.addSubview(openOverviewImage)
    }
    
    override func setConstraints() {
        openOverviewImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
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
//        openOverviewImage.image = nil
    }
    
}
