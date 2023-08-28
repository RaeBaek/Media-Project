//
//  TrendingView.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/28.
//

import UIKit

class TrendingView: BaseView {
    
    lazy var tmdbCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        
        // storyboard와 nib로 작업하는 경우에는 register 부분을 UINib로 선언해주어야한다.
        // 반면에 code base로 작업하게 된다면 화면전환 시 클래스를 바로 호출하는 것과 같이
        // 바로 cell 파일을 호출하면 된다.
//        let nib = UINib(nibName: TMDBCollectionViewCell.identifier, bundle: nil)
        
        view.register(TMDBCollectionViewCell.self, forCellWithReuseIdentifier: TMDBCollectionViewCell.identifier)
        
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        tmdbCollectionView.backgroundColor = .systemBackground
        addSubview(tmdbCollectionView)
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        tmdbCollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let releseDateHeight: CGFloat = 10
        let genreHeight: CGFloat = 20
        
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width
        print(width)
        
        layout.itemSize = CGSize(width: width, height: width + releseDateHeight + genreHeight)
        print(layout.itemSize)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
        
    }
    
}
