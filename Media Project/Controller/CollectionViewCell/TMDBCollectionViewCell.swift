//
//  TMDBCollectionViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/14.
//

import UIKit

class TMDBCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var shadowBackView: UIView!
    @IBOutlet var backView: UIView!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieActorsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        
    }
    
    func configureCell() {
        
        shadowBackView.clipsToBounds = false
        shadowBackView.layer.cornerRadius = 10
        shadowBackView.layer.shadowColor = UIColor.black.cgColor
        // 햇빛이 비추는 위치
        shadowBackView.layer.shadowOffset = .zero //CGSize(width: 0, height: 0)
        // 섀도우 퍼짐의 정도
        shadowBackView.layer.shadowRadius = 5
        // 섀도우 불투명도
        shadowBackView.layer.shadowOpacity = 0.5
        
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        
        releaseDateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        releaseDateLabel.textColor = .darkGray
        
        genreLabel.font = .systemFont(ofSize: 17, weight: .bold)
        genreLabel.textColor = .black
        
        backdropImageView.contentMode = .scaleAspectFill
        
        movieTitleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        movieTitleLabel.textColor = .black
        
        movieActorsLabel.font = .systemFont(ofSize: 15, weight: .regular)
        movieActorsLabel.textColor = .darkGray
        
        
    }

}
