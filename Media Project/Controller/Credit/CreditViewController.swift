//
//  CreditViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/13.
//

import UIKit

struct Caster {
    var name: String
    var profileURL: URL
    var character: String
}

class CreditViewController: BaseViewController {
    
//    @IBOutlet var creditTableView: UITableView!
//    @IBOutlet var backImageView: UIImageView!
//    @IBOutlet var movieTitleLabel: UILabel!
//    @IBOutlet var posterImageView: UIImageView!
    
    let mainView = CreditView()
    
    var credit: Int?
    var isExpand: Bool = false
    
    var movieInfo: TMDBMovieInfo?
    var credits: TMDBCredit?
    
    //디스패치 그룹!!
    let group = DispatchGroup()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        title = "출연/제작"
        
//        navigationController?.navigationBar.topItem?.title = ""
//        navigationController?.navigationBar.tintColor = .black
        
//        let backButton = UIBarButtonItem(title: "gdgd", style: .done, target: self, action: #selector(backButtonClicked))
//        backButton.tintColor = .black
//        self.navigationItem.backBarButtonItem = backButton
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black
        
        mainView.creditTableView.delegate = self
        mainView.creditTableView.dataSource = self
        
        guard let credit = self.credit else { return }
        print("Credit: \(credit)")
        
        group.enter()
        print("ㅎㅇㅎㅇㅎㅇ")
        callRequestMovieInfoAPI(credit: credit)
        
        print("ㅂㅇㅂㅇㅂㅇ")
        
        group.enter()
        callRequestCreditAPI(mediaType: .movie, credit: credit)
        
        
        group.notify(queue: .main) {
            self.mainView.creditTableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    @objc func backButtonClicked() {
        self.movieInfo = nil
        self.credit = nil
        self.credits = nil
    }
    
    func callRequestMovieInfoAPI(credit: Int) {
        TMDBAPIManager.shared.requestMovieInfoAPI(credit: credit) { response in
            
            print(credit)
            self.movieInfo = response
            
            guard let backdropPath = self.movieInfo?.backdropPath else { return }
            guard let posterPath = self.movieInfo?.posterPath else { return }
            guard let backdropURL = URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)") else { return }
            guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)") else { return }
            guard let movieTitle = self.movieInfo?.title else { return }
            
            self.mainView.backImageView.kf.setImage(with: backdropURL)
            self.mainView.posterImageView.kf.setImage(with: posterURL)
            self.mainView.movieTitleLabel.text = movieTitle
            
            self.group.leave()
        }
    }
    
    func callRequestCreditAPI(mediaType: MediaType, credit: Int) {
        TMDBAPIManager.shared.requestCreditAPI(mediaType: mediaType, credit: credit) { response in
            
            self.credits = response
            print("Credits IDdddddddddd: ", self.credits?.id)
            
            self.group.leave()
        }
    }

}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Overview" : "Cast"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = self.credits?.cast.count else { return 0 }
        print("Counttttt:", count)
        
        return section == 0 ? 2 : count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return UITableView.automaticDimension
            } else {
                return 30
            }
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
                
                cell.overviewLabel.text = self.movieInfo?.overview
                cell.overviewLabel.numberOfLines = isExpand ? 0 : 2
                cell.selectionStyle = .none
//                cell.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewButtonTableViewCell.identifier) as? OverviewButtonTableViewCell else { return UITableViewCell() }
                cell.openOverviewImage.image = isExpand ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
                
                cell.selectionStyle = .none
                
                return cell
            }
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as? CreditTableViewCell else { return UITableViewCell() }
            
//            DispatchQueue.global().async {
                guard let profilePath = self.credits?.cast[indexPath.row].profilePath else { return UITableViewCell() }
                guard let profileURL = URL(string: "https://image.tmdb.org/t/p/original\(profilePath)") else { return UITableViewCell() }
                guard let name = self.credits?.cast[indexPath.row].name else { return UITableViewCell() }
                guard let character = self.credits?.cast[indexPath.row].character else { return UITableViewCell() }
                
//                DispatchQueue.main.async {
                    cell.profileImageView.kf.setImage(with: profileURL)
                    cell.nameLabel.text = name
                    cell.characterLabel.text = character
//                }
//            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isExpand.toggle()
        if indexPath == IndexPath(row: 1, section: 0) {
            tableView.reloadRows(at: [indexPath, IndexPath(row: 0, section: 0)], with: .automatic)
        } else {
            return
        }
        
    }
}
