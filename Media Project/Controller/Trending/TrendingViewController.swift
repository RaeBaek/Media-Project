//
//  TrendingViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/12.
//

import UIKit
import Kingfisher

class TrendingViewController: BaseViewController {
    
    let listButton = {
        let view = UIBarButtonItem()
        view.image = UIImage(systemName: "list.bullet")
        view.tintColor = .black
        return view
    }()
    
    lazy var personButton = {
        let view = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: #selector(personButtonClicked(_:)))
        view.tintColor = .black
        return view
    }()
    
    let mainView = TrendingView()
    
    var trending: TMDBTrending?
    
    var actors: [String] = []
    var actorsList: [[String]] = []
    
    let genreList = TMDBGenre()
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
    
    override func loadView() {
        self.view = mainView
        mainView.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationItem.rightBarButtonItem =
        
        //애초에 비동기이기 때문에 또 비동기 처리를 할 필요가 없다.
        self.callRequestTrendAPI(mediaType: .movie, timeWindow: .week)
        
    }
    
    override func configureView() {
        super.configureView()
        
        title = "TMDB"
        
        navigationItem.leftBarButtonItem = listButton
        navigationItem.rightBarButtonItem = personButton
        navigationItem.backButtonTitle = ""
        
        mainView.tmdbCollectionView.delegate = self
        mainView.tmdbCollectionView.dataSource = self
        
    }
    
    override func setConstraints() {
        
    }
    
    @objc func personButtonClicked(_ sender: UIBarButtonItem) {
        let vc = ProfileEditViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func callRequestTrendAPI(mediaType: MediaType, timeWindow: EndPoint) {
        TMDBAPIManager.shared.requestTrendAPI(mediaType: mediaType, timeWindow: timeWindow) { result in
            // 영화 id credit
            // https://api.themoviedb.org/3/movie/{movie_id}/credits
            
            self.trending = result
            
            let result = result.results
                
            // 영화 개별 크레딧 받아오는 Credit API
            // 총 20개의 영화로 각각 크레딧을 받아와야한다.
            print("callRequestCreditAPI 정상 실행")
            for i in 0..<result.count {
                //애초에 비동기이기 때문에 또 비동기 처리를 할 필요가 없다.
                self.callRequestCreditAPI(mediaType: mediaType, credit: result[i].id)
                
            }
        }
    }
    
    func callRequestCreditAPI(mediaType: MediaType, credit: Int) {
        TMDBAPIManager.shared.requestCreditAPI(mediaType: mediaType, credit: credit) { response in
            
            print("creditAPI 호출 시작")
            
            let casts = [response.cast[0].name, response.cast[1].name, response.cast[2].name, response.cast[3].name]
            
            for item in casts {
                guard let item = item else { return }
                self.actors.append(item)
                print("나 액터즈: ", self.actors)
            }
            
            self.actorsList.append(self.actors)
            print("나 액터즈 리스트: ", self.actorsList)
            self.actors.removeAll()
            print("나 액터즈: ", self.actors)
            
            //최종적으로 API 호출을 마무리하는 지점에서 reload를 진행해주자!
            self.mainView.tmdbCollectionView.reloadData()
        }
    }
}

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
            
            guard let backdropPath = self.trending?.results[indexPath.row].backdropPath else { return }
            guard let backdropUrl = URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)") else { return }
            guard let releaseDate = self.trending?.results[indexPath.row].releaseDate else { return }
            guard let genre = self.trending?.results[indexPath.row].genreIDS[0] else { return }
            guard let genreValue = self.genreList.genreDict[genre] else { return }
            guard let title = self.trending?.results[indexPath.row].title else { return }
            guard let originalTitle = self.trending?.results[indexPath.row].originalTitle else { return }
            
            DispatchQueue.main.async {
                cell.backdropImageView.kf.setImage(with: backdropUrl)
                cell.releaseDateLabel.text = releaseDate
                cell.movieTitleLabel.text = title
                cell.movieOriginalTitle.text = originalTitle
                cell.genreLabel.text = "#\(genreValue)"
                cell.movieActorsLabel.text = "\(self.actorsList[indexPath.row][0]), \(self.actorsList[indexPath.row][1]), \(self.actorsList[indexPath.row][2]), \(self.actorsList[indexPath.row][3])"
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let creditViewController = storyboard?.instantiateViewController(identifier: CreditViewController.identifier) as? CreditViewController else { return }
        let vc = CreditViewController()
        
//        guard let tmdbSegmentViewController = storyboard?.instantiateViewController(identifier: TMDBSegmentViewController.identifier) as? TMDBSegmentViewController else { return }

        vc.credit = self.trending?.results[indexPath.row].id
        
        // 확인!!!!!!!!!!
        // 네트워크 로딩이 상대적으로 길게 느껴진다면?
        // TrendingViewController에서 API를 호출해버리고 값을 넘겨버리는 것이다.
//        vc.callRequestMovieInfoAPI(credit: <#T##Int#>)
        
        
//        tmdbSegmentViewController.credit = self.trending?.results[indexPath.row].id
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
