//
//  TMDBCollectionViewCell.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/14.
//

import UIKit

class TMDBCollectionViewCell: BaseCollectionViewCell {
    
    let releaseDateLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .darkGray
        return view
    }()
    
    let genreLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17, weight: .bold)
        view.textColor = .black
        return view
    }()
    
    let shadowBackView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        // 햇빛이 비추는 위치
        view.layer.shadowOffset = .zero //CGSize(width: 0, height: 0)
        // 섀도우 퍼짐의 정도
        view.layer.shadowRadius = 5
        // 섀도우 불투명도
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let backView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let backdropImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let movieTitleLabel = {
        let view = UILabel()
        view.setContentHuggingPriority(.init(252), for: .horizontal)
        view.setContentCompressionResistancePriority(.init(750), for: .horizontal)
        view.font = .systemFont(ofSize: 20, weight: .regular)
        view.textColor = .black
        return view
    }()
    
    let movieOriginalTitle = {
        let view = UILabel()
        view.setContentHuggingPriority(.init(251), for: .horizontal)
        view.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textColor = .black
        return view
    }()
    
    let movieActorsLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textColor = .darkGray
        return view
    }()
    
    let middleLineView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let detailLabel = {
        let view = UILabel()
        view.text = "자세히 보기"
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .black
        return view
    }()
    
    let rightImage = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        backdropImageView.image = nil
    }
    
    override func configureCell() {
        
        [releaseDateLabel, genreLabel, shadowBackView, backView].forEach {
            contentView.addSubview($0)
        }
        
        [backdropImageView, movieTitleLabel, movieOriginalTitle, movieActorsLabel, middleLineView, detailLabel, rightImage].forEach {
            backView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        releaseDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(13)
        }
        
        genreLabel.snp.makeConstraints {
            $0.top.equalTo(releaseDateLabel.snp.bottom)
            $0.leading.equalTo(releaseDateLabel.snp.leading)
        }

        shadowBackView.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(shadowBackView.snp.width).multipliedBy(1)
        }

        backView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(shadowBackView)
        }

        backdropImageView.snp.makeConstraints {
            $0.top.equalTo(backView)
            $0.horizontalEdges.equalTo(backView.snp.horizontalEdges)
            $0.height.equalTo(backView.snp.width).multipliedBy(0.65)
        }

        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(backdropImageView.snp.bottom).offset(15)
            $0.leading.equalTo(backView.snp.leading).offset(20)
        }
        
        movieOriginalTitle.snp.makeConstraints {
            $0.centerY.equalTo(movieTitleLabel)
            $0.trailing.equalTo(backView.snp.trailing).offset(-20)
            $0.leading.equalTo(movieTitleLabel.snp.trailing).offset(10)
        }
        
        movieActorsLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(backView.snp.leading).offset(20)
            $0.trailing.equalTo(backView.snp.trailing).offset(-20)
        }
        
        detailLabel.snp.makeConstraints {
            $0.leading.equalTo(backView.snp.leading).offset(16)
            $0.bottom.equalTo(backView.snp.bottom).offset(-15)
        }

        rightImage.snp.makeConstraints {
            $0.centerY.equalTo(detailLabel)
            $0.trailing.equalTo(backView.snp.trailing).offset(-14)
            $0.size.equalTo(20)
        }

        middleLineView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(backView).inset(16)
            $0.bottom.equalTo(detailLabel.snp.top).offset(-15)
            $0.height.equalTo(1)
        }
    }

}
