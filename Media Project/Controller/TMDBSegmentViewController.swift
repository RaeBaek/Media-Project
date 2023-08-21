//
//  TMDBSegmentViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/21.
//

import UIKit
import Kingfisher

class TMDBSegmentViewController: UIViewController {

    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var segmentCollectionView: UICollectionView!
    
    var credit: Int?
    var segmentValue = 0 {
        didSet {
            segmentCollectionView.reloadData()
            print("세그먼트 값 바뀜:", segmentValue)
        }
    }
    var similarList: TMDBSimilar?
    var vedioList: TMDBVedio?
    let genreList = TMDBGenre()
    
    //디스패치 그룹!!
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("뷰디드로드 나옴나옴나옴")
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        
        let nib = UINib(nibName: TMDBCollectionViewCell.identifier, bundle: nil)
        
        segmentCollectionView.register(nib, forCellWithReuseIdentifier: TMDBCollectionViewCell.identifier)
        
        segmentCollectionView.delegate = self
        segmentCollectionView.dataSource = self
        
        print("크레딧 받았죠?:", credit)
        
        setCollectionViewLayout()
        
        guard let credit = credit else { return }
        group.enter()
        TMDBAPIManager.shared.requestSimilarAPI(id: credit) { result in
            self.similarList = result
            self.segmentCollectionView.reloadData()
            self.group.leave()
        }
        
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        guard let credit = credit else { return }
        if segmentControl.selectedSegmentIndex == 0 {
            segmentValue = 0
            
//            self.group.enter()
//            TMDBAPIManager.shared.requestSimilarAPI(id: credit) { result in
//                self.similarList = result
//                self.group.leave()
//            }
            
        } else {
            segmentControl.selectedSegmentIndex = 1
            segmentValue = 1
            
            self.group.enter()
            TMDBAPIManager.shared.requestVedioAPI(id: credit) { result in
                self.vedioList = result
                self.group.leave()
            }
        }
    }
    
    func setCollectionViewLayout() {
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
        
        segmentCollectionView.collectionViewLayout = layout
        
    }

}

extension TMDBSegmentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if segmentControl.selectedSegmentIndex == 0 {
            guard let count = self.similarList?.results.count else { return 0 }
            return count
        } else {
            guard let count = self.vedioList?.results?.count else { return 0 }
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.identifier, for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell() }
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            guard let releaseDate = self.similarList?.results[indexPath.row].releaseDate else { return UICollectionViewCell() }
            guard let genre = self.similarList?.results[indexPath.row].genreIDS[0] else { return UICollectionViewCell() }
            guard let genreValue = self.genreList.genreDict[genre] else { return UICollectionViewCell() }
            guard let backdropPath = self.similarList?.results[indexPath.row].backdropPath else { return UICollectionViewCell() }
            guard let backdropUrl = URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)") else { return UICollectionViewCell() }
            
            guard let title = self.similarList?.results[indexPath.row].title else { return UICollectionViewCell() }
            guard let originalTitle = self.similarList?.results[indexPath.row].originalTitle else { return UICollectionViewCell() }
            
            cell.releaseDateLabel.text = releaseDate
            cell.genreLabel.text = "#\(genreValue)"
            cell.backdropImageView.kf.setImage(with: backdropUrl)
            cell.movieTitleLabel.text = title
            cell.movieOriginalTitle.text = ""
            cell.movieActorsLabel.text = originalTitle
            
        } else {
            guard let publishedAt = self.vedioList?.results?[indexPath.row].publishedAt else { return UICollectionViewCell() }
            guard let type = self.vedioList?.results?[indexPath.row].type else { return UICollectionViewCell() }
            guard let name = self.vedioList?.results?[indexPath.row].name else { return UICollectionViewCell() }
            guard let site = self.vedioList?.results?[indexPath.row].site else { return UICollectionViewCell() }
            
            cell.releaseDateLabel.text = publishedAt
            cell.genreLabel.text = "#\(type)"
            cell.movieTitleLabel.text = name
            cell.movieActorsLabel.text = site
        }
        
        return cell
    }
    
    
}
