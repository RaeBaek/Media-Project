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

class CreditViewController: UIViewController {
    
    @IBOutlet var creditTableView: UITableView!
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    
//    var backURL: URL?
//    var posterURL: URL?
//    var movieTitle: String?
    var credit: Int?
//    var overView: String?
//    var creditList: [Caster] = []
    
    var movieInfo: TMDBMovieInfo?
    var credits: TMDBCredit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        title = "출연/제작"
        
//        navigationController?.navigationBar.topItem?.title = ""
//        navigationController?.navigationBar.tintColor = .black
        
        let backButton = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(backButtonClicked))
        backButton.tintColor = .black
        self.navigationItem.backBarButtonItem = backButton
        
        creditTableView.delegate = self
        creditTableView.dataSource = self
//        creditTableView.rowHeight = 80
        
        creditTableView.sectionHeaderHeight = 40
        creditTableView.sectionFooterHeight = 0
        creditTableView.backgroundColor = .systemBackground
        // 아래 코드는 테이블 전체가 변하므로
        // 섹션별로 바꿀 수 있는 코드는 없는지 알아보자
//        creditTableView.separatorStyle = .none
//        creditTableView.separatorColor = .clear
        
        let nib = UINib(nibName: CreditTableViewCell.identifier, bundle: nil)
        let nib2 = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        let nib3 = UINib(nibName: OverviewButtonTableViewCell.identifier, bundle: nil)
        creditTableView.register(nib, forCellReuseIdentifier: CreditTableViewCell.identifier)
        creditTableView.register(nib2, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        creditTableView.register(nib3, forCellReuseIdentifier: OverviewButtonTableViewCell.identifier)
        
//        DispatchQueue.global().async {
            guard let credit = self.credit else { return }
            print("실행되잖아요")
            print("Credit: \(credit)")
            
            self.callRequestMovieInfoAPI(credit: credit)
            
            print("실행되긴해 뭐가 문제야")
//        }
        
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        backImageView.contentMode = .scaleAspectFill
        
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
        print(credit)
        print("들어왔잖아요")
        TMDBAPIManager.shared.requestMovieInfoAPI(credit: credit) { response in
            
            print(credit)
            self.movieInfo = response
            
            print("또 들어간다!!!!")
//            DispatchQueue.global().async {
                print("또 들어왔다????")
                self.callRequestCreditAPI(mediaType: .movie, credit: credit)
                
                guard let backdropPath = self.movieInfo?.backdropPath else { return }
                guard let posterPath = self.movieInfo?.posterPath else { return }
                guard let backdropURL = URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)") else { return }
                guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)") else { return }
                guard let movieTitle = self.movieInfo?.title else { return }
                
//                DispatchQueue.main.async {
                    self.backImageView.kf.setImage(with: backdropURL)
                    self.posterImageView.kf.setImage(with: posterURL)
                    self.movieTitleLabel.text = movieTitle
//                }
//            }
//            self.creditTableView.reloadData()
        }
    }
    
    func callRequestCreditAPI(mediaType: MediaType, credit: Int) {
        TMDBAPIManager.shared.requestCreditAPI(mediaType: mediaType, credit: credit) { response in
            
            self.credits = response
            print("Credits IDdddddddddd: ", self.credits?.id)
            
            self.creditTableView.reloadData()
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
                return 70
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
                cell.selectionStyle = .none
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewButtonTableViewCell.identifier) as? OverviewButtonTableViewCell else { return UITableViewCell() }
                
                cell.selectionStyle = .none
                
                return cell
            }
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as? CreditTableViewCell else { return UITableViewCell() }
            
            DispatchQueue.global().async {
                guard let profilePath = self.credits?.cast[indexPath.row].profilePath else { return }
                guard let profileURL = URL(string: "https://image.tmdb.org/t/p/original\(profilePath)") else { return }
                guard let name = self.credits?.cast[indexPath.row].name else { return }
                guard let character = self.credits?.cast[indexPath.row].character else { return }
                
                DispatchQueue.main.async {
                    cell.profileImageView.kf.setImage(with: profileURL)
                    cell.nameLabel.text = name
                    cell.characterLabel.text = character
                }
            }
            
            cell.selectionStyle = .none
            return cell
        }
        
        
    }
    
}
