//
//  TMDBViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/12.
//

import UIKit
import Kingfisher

struct Movie {
    var title: String
    var backdropURL: URL
    var posterURL: URL
    var releaseDate: String
    var genreId: Int
    var id: Int
    var overview: String
}

struct Actor {
    var name: String
}

class TMDBViewController: UIViewController {
    
    //    @IBOutlet var tmdbTableView: UITableView!
    @IBOutlet var tmdbCollectionView: UICollectionView!
    //    @IBOutlet var mediaTypeTextField: UITextField!
    //    @IBOutlet var timeWindowTextField: UITextField!
    @IBOutlet var listButton: UIBarButtonItem!
    @IBOutlet var searchButton: UIBarButtonItem!
    
    var movieList: [Movie] = []
    var actors: [Actor] = []
    var actorsList: [[Actor]] = []
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
    
//    let genreDict = GenreDict()
    
    let mediaPickerView = UIPickerView()
    let timePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TMDB"
        
        searchButton.title = "검색"
        searchButton.tintColor = .black
        
        listButton.title = "리스트"
        listButton.tintColor = .black
        
        mediaPickerView.delegate = self
        mediaPickerView.dataSource = self
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        let nib = UINib(nibName: TMDBCollectionViewCell.identifier, bundle: nil)
        tmdbCollectionView.register(nib, forCellWithReuseIdentifier: TMDBCollectionViewCell.identifier)
        
        tmdbCollectionView.delegate = self
        tmdbCollectionView.dataSource = self
        
        dismissPickerView()
        setCollectionViewLayout()
        
        print("시작")
        
        DispatchQueue.global().sync {
            callRequestTrendAPI(mediaType: .movie, timeWindow: .week)
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
    
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        //        mediaTypeTextField.inputAccessoryView = toolBar
        //        timeWindowTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    func callRequestTrendAPI(mediaType: MediaType, timeWindow: EndPoint) {
        TMDBAPIManager.shared.requestTrendAPI(mediaType: mediaType, timeWindow: timeWindow) { json in
            // 영화 id credit
            // https://api.themoviedb.org/3/movie/{movie_id}/credits
            
//            self.totalPages = json["total_pages"].intValue
//            print(self.totalPages)
            
            for item in json["results"].arrayValue {
                let title = item["title"].stringValue
                let backdropURL = item["backdrop_path"].stringValue
                let posterURL = item["poster_path"].stringValue
                let releaseDate = item["release_date"].stringValue
                let genreIds = item["genre_ids"].arrayValue
                let genre = genreIds[0].intValue
                let id = item["id"].intValue
                let overview = item["overview"].stringValue
                
                DispatchQueue.global().async {
                    self.callRequestCreditAPI(mediaType: mediaType, credit: id)
                }
                
                guard let genreValue = self.genreDict[genre] else { return }
                self.genreList.append(genreValue)
                print(self.genreList)
                
                
                print("callRequestCreditAPI 정상 실행")
                
                guard let backdropUrl = URL(string: "https://image.tmdb.org/t/p/original\(backdropURL)") else { return }
                
                guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original\(posterURL)") else { return }
                
                // 오리지널 이미지 가져오는 링크
                // https://image.tmdb.org/t/p/original/xVMtv55caCEvBaV83DofmuZybmI.jpg
                
                // w500 사이즈 이미지 가져오는 링크
                // https://image.tmdb.org/t/p/w500\(posterURL)
                
                let data = Movie(title: title, backdropURL: backdropUrl, posterURL: posterURL, releaseDate: releaseDate, genreId: genre, id: id, overview: overview)
                print(data)
                
                self.movieList.append(data)
                print("movieList 잘 들어감")
                
            }
            self.tmdbCollectionView.reloadData()
            print("끝")
        }
        
    }
    
    func callRequestCreditAPI(mediaType: MediaType, credit: Int) {
        TMDBAPIManager.shared.requestCreditAPI(mediaType: mediaType, credit: credit) { json in
//            print(json)
            
            print("creditAPI 호출 시작")
            let casts = [json["cast"][0], json["cast"][1], json["cast"][2], json["cast"][3]]
            print("여기여기여기여기")
            print(casts)
            
//            let items = [cast[0], cast[1], cast[2], cast[3]]
            
            for item in casts {
                let name = item["name"].stringValue
                let data = Actor(name: name)
                self.actors.append(data)
                print("나 액터즈: ", self.actors)
            }
            
            self.actorsList.append(self.actors)
            print("나 액터즈 리스트: ", self.actorsList)
            self.actors.removeAll()
            print("나 액터즈: ", self.actors)
            self.tmdbCollectionView.reloadData()
        }
    }
    
    func searchGenre(genre: Int) {
        
    }
    
}

extension TMDBViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TMDBCollectionViewCell.identifier, for: indexPath) as? TMDBCollectionViewCell else { return UICollectionViewCell() }
        
        cell.releaseDateLabel.text = "\(self.movieList[indexPath.row].releaseDate)"
        cell.backdropImageView.kf.setImage(with: self.movieList[indexPath.row].backdropURL)
        cell.movieTitleLabel.text = self.movieList[indexPath.row].title
        
        // 글로벌 비동기에 배우라벨만 넣으면 실행된다.
        // 나머지 라벨을 넣어버리면 멈춰버리는데 왜...?
        // 그리고 API 호출 함수를 현재 모두 글로벌 비동기로 처리한 상태이다.
        DispatchQueue.main.async {
            cell.genreLabel.text = "#\(self.genreList[indexPath.row])"
            cell.movieActorsLabel.text = "\(self.actorsList[indexPath.row][0].name), \(self.actorsList[indexPath.row][1].name), \(self.actorsList[indexPath.row][2].name), \(self.actorsList[indexPath.row][3].name)"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: CreditViewController.identifier) as? CreditViewController else { return }
        
        vc.backURL = movieList[indexPath.row].backdropURL
        vc.posterURL = movieList[indexPath.row].posterURL
        vc.movieTitle = movieList[indexPath.row].title
        vc.credit = movieList[indexPath.row].id
        vc.overView = movieList[indexPath.row].overview
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TMDBViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == mediaPickerView {
            return MediaType.allCases.count
        } else {
            return EndPoint.allCases.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == mediaPickerView {
            return "\(MediaType.allCases[row].self)"
        } else {
            return "\(EndPoint.allCases[row].self)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        if pickerView == mediaPickerView {
        //            mediaTypeTextField.text = "\(MediaType.allCases[row].self)"
        //        } else {
        //            timeWindowTextField.text = "\(EndPoint.allCases[row].self)"
        //        }
    }
    
}
