//
//  TMDBTableViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/12.
//

import UIKit

class TMDBTableViewCell: UITableViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var mediaTypeLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var voteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 5
        
        movieTitleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        mediaTypeLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        releaseDateLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        voteLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
    }
    
}
