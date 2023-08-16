//
//  TMDBViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/12.
//

import UIKit
import Kingfisher

class TMDBViewController: UIViewController {
    
    @IBOutlet var tmdbCollectionView: UICollectionView!
    @IBOutlet var listButton: UIBarButtonItem!
    @IBOutlet var searchButton: UIBarButtonItem!
    
    var trending: TMDBTrending?
    
    var actors: [String] = []
    var actorsList: [[String]] = []
    var genreList: [String] = []
    
    let genreDict = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TMDB"
        
        searchButton.title = "검색"
        searchButton.tintColor = .black
        
        listButton.title = "리스트"
        listButton.tintColor = .black
        
        let nib = UINib(nibName: TMDBCollectionViewCell.identifier, bundle: nil)
        tmdbCollectionView.register(nib, forCellWithReuseIdentifier: TMDBCollectionViewCell.identifier)
        
        tmdbCollectionView.delegate = self
        tmdbCollectionView.dataSource = self
        
        setCollectionViewLayout()
        
        print("시작")
        
        DispatchQueue.global().async {
            self.callRequestTrendAPI(mediaType: .movie, timeWindow: .week)
        }
        
        print("뭐하냐????")
        
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
        
        tmdbCollectionView.collectionViewLayout = layout
        
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    func callRequestTrendAPI(mediaType: MediaType, timeWindow: EndPoint) {
        TMDBAPIManager.shared.requestTrendAPI(mediaType: mediaType, timeWindow: timeWindow) { result in
            // 영화 id credit
            // https://api.themoviedb.org/3/movie/{movie_id}/credits
            
//            self.totalPages = json["total_pages"].intValue
//            print(self.totalPages)
            
            self.trending = result
            
            let result = result.results
                
            // 영화 개별 크레딧 받아오는 Credit API
            // 총 20개의 영화로 각각 크레딧을 받아와야한다.
            print("callRequestCreditAPI 정상 실행")
                DispatchQueue.global().async {
                    for i in 0..<result.count {
                        self.callRequestCreditAPI(mediaType: mediaType, credit: result[i].id)
                        
                        // 장르 받아오기
                        // 장르 또한 각각의 셀에서 하나씩 받아와야 하는거같다...?
                        guard let genreValue = self.genreDict[result[i].genreIDS[0]] else { return }
                        self.genreList.append(genreValue)
                        print(self.genreList)
                    }
                    
                }
            // 제일 마지막의 API 호출 시점에 reload를 해주는게 제일 좋은거같다?!
//            self.tmdbCollectionView.reloadData()
            // 음 그렇다면 API 갯수가 몇개든 다 호출이 되는 시점에 reload 해주면 되지 않을까?
            // 그것이 바로 DispatchGroup이다!!
            print("끝")
            
            print("movieList 잘 들어감")
            
            
        }
        
    }
    
    func callRequestCreditAPI(mediaType: MediaType, credit: Int) {
        TMDBAPIManager.shared.requestCreditAPI(mediaType: mediaType, credit: credit) { response in
            
            print("creditAPI 호출 시작")
            let casts = [response.cast[0].name, response.cast[1].name, response.cast[2].name, response.cast[3].name]
            print("여기여기여기여기")
            print(casts)
            
//            let items = [cast[0], cast[1], cast[2], cast[3]]
            
            for item in casts {
                self.actors.append(item)
                print("나 액터즈: ", self.actors)
            }
            self.actorsList.append(self.actors)
            print("나 액터즈 리스트: ", self.actorsList)
            self.actors.removeAll()
            print("나 액터즈: ", self.actors)
            
            //최종적으로 API 호출을 마무리하는 지점에서 reload를 진행해주자!
            self.tmdbCollectionView.reloadData()
        }
    }
    
}

extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = self.trending?.results.count else { return 0 }
        print("메인뷰 총 카운트:", count)
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.identifier, for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell() }
        
        DispatchQueue.global().async {
            
            // 오리지널 이미지 가져오는 링크
            // https://image.tmdb.org/t/p/original/xVMtv55caCEvBaV83DofmuZybmI.jpg
            
            // w500 사이즈 이미지 가져오는 링크
            // https://image.tmdb.org/t/p/w500\(posterURL)
//            guard let trending = trending else { return UICollectionViewCell() }
            
            guard let backdropPath = self.trending?.results[indexPath.row].backdropPath else { return }
            guard let backdropUrl = URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)") else { return }
            guard let releaseDate = self.trending?.results[indexPath.row].releaseDate else { return }
            guard let title = self.trending?.results[indexPath.row].title else { return }
            
            // 글로벌 비동기에 배우라벨만 넣으면 실행된다.
            // 나머지 라벨을 넣어버리면 멈춰버리는데 왜...?
            // 그리고 API 호출 함수를 현재 모두 글로벌 비동기로 처리한 상태이다.
            DispatchQueue.main.async {
                cell.backdropImageView.kf.setImage(with: backdropUrl)
                cell.releaseDateLabel.text = releaseDate
                cell.movieTitleLabel.text = title
                cell.genreLabel.text = "#\(self.genreList[indexPath.row])"
                cell.movieActorsLabel.text = "\(self.actorsList[indexPath.row][0]), \(self.actorsList[indexPath.row][1]), \(self.actorsList[indexPath.row][2]), \(self.actorsList[indexPath.row][3])"
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: CreditViewController.identifier) as? CreditViewController else { return }
        
//        vc.backURL = movieList[indexPath.row].backdropURL
//        vc.posterURL = movieList[indexPath.row].posterURL
//        vc.movieTitle = movieList[indexPath.row].title
        vc.credit = self.trending?.results[indexPath.row].id
//        vc.overView = movieList[indexPath.row].overview
        
        print("아이디 전다아아아아ㅏㅇㄹ:", self.trending?.results[indexPath.row].id)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
