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
    var posterURL: URL
    var mediaType: String
    var releaseDate: String
    var voteCount: Int
    var voteAvg: Double
    var id: Int
    
    var voteInfo: String {
        return "Vote Count: \(voteCount) | Vote Average: \(voteAvg)"
    }
}

class TMDBViewController: UIViewController {
    
    @IBOutlet var tmdbTableView: UITableView!
    @IBOutlet var mediaTypeTextField: UITextField!
    @IBOutlet var timeWindowTextField: UITextField!
    @IBOutlet var searchButton: UIBarButtonItem!
    
    var movieList: [Movie] = []
    var page = 1
    var totalPages = 0
    
    let mediaPickerView = UIPickerView()
    let timePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TMDB"
        
        searchButton.title = "검색"
        searchButton.tintColor = .black
        
        mediaPickerView.delegate = self
        mediaPickerView.dataSource = self
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        mediaTypeTextField.placeholder = "media type select"
        mediaTypeTextField.inputView = mediaPickerView
        mediaTypeTextField.tintColor = .clear
        
        timeWindowTextField.placeholder = "time window select"
        timeWindowTextField.inputView = timePickerView
        timeWindowTextField.tintColor = .clear
        
        tmdbTableView.dataSource = self
        tmdbTableView.delegate = self
        tmdbTableView.prefetchDataSource = self
        tmdbTableView.rowHeight = 140
        
        dismissPickerView()
        
        callRequest(mediaType: .movie, timeWindow: .week)
        
        
    }
    
    @IBAction func searchButtonTapped(_ sender: UIBarButtonItem) {
        
        movieList.removeAll()
//        page = 1
        
        guard let media = mediaTypeTextField.text else { return }
        guard let time = timeWindowTextField.text else { return }
        callRequest(mediaType: MediaType(rawValue: media)!, timeWindow: EndPoint(rawValue: time)!)
        
    }
    
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        mediaTypeTextField.inputAccessoryView = toolBar
        timeWindowTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        view.endEditing(true)
    }
    
    func callRequest(mediaType: MediaType, timeWindow: EndPoint) {
        TMDBAPIManager.shared.requestTrendAPI(mediaType: mediaType, timeWindow: timeWindow) { json in
            
            // 영화 id credit
            // https://api.themoviedb.org/3/movie/{movie_id}/credits
            
            self.totalPages = json["total_pages"].intValue
            print(self.totalPages)
            
            for item in json["results"].arrayValue {
                let title = item["title"].stringValue
                let posterURL = item["poster_path"].stringValue
                let mediaType = item["media_type"].stringValue
                let releaseDate = item["release_date"].stringValue
                let voteCount = item["vote_count"].intValue
                let voteAvg = item["vote_average"].doubleValue
                let id = item["id"].intValue
                
                guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterURL)") else { return }
                
                let data = Movie(title: title, posterURL: url, mediaType: mediaType, releaseDate: releaseDate, voteCount: voteCount, voteAvg: voteAvg, id: id)
                self.movieList.append(data)
            }
            self.tmdbTableView.reloadData()
            print(self.movieList)
            
        }
    }
    
}

// UITableViewDataSourcePrefetching: iOS10 이상 사용 가능한 프로토콜, CellForRowAt이 호출되기 전에 먼저 호출 됨.
extension TMDBViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운받는 기능
    // videoList 갯수와 indexPath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    // page count
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //        for indexPath in indexPaths {
        //            if movieList.count - 1 == indexPath.row && page < totalPages {
        //                page += 1
        //                requestAPI(mediaType: .movie, timeWindow: .week)
        //            }
        //        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("====취소 \(indexPaths)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TMDBTableViewCell.identifier) as? TMDBTableViewCell else {
            return UITableViewCell()
        }
        
        cell.posterImageView.kf.setImage(with: movieList[indexPath.row].posterURL)
        cell.movieTitleLabel.text = movieList[indexPath.row].title
        cell.mediaTypeLabel.text = "Media: \(movieList[indexPath.row].mediaType)"
        cell.releaseDateLabel.text = "ReleaseDate: \(movieList[indexPath.row].releaseDate)"
        cell.voteLabel.text = movieList[indexPath.row].voteInfo
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(identifier: CreditViewController.identifier) as? CreditViewController else { return }
        
        vc.credit = movieList[indexPath.row].id
        
        navigationController?.pushViewController(vc, animated: true)
        
        return
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
        if pickerView == mediaPickerView {
            mediaTypeTextField.text = "\(MediaType.allCases[row].self)"
        } else {
            timeWindowTextField.text = "\(EndPoint.allCases[row].self)"
        }
    }
    
}
