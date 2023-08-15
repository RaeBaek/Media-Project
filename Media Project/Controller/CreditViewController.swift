//
//  CreditViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/13.
//

import UIKit

struct Cast {
    var name: String
    var profileURL: URL
    var character: String
}

class CreditViewController: UIViewController {
    
    @IBOutlet var creditTableView: UITableView!
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    
    var backURL: URL?
    var posterURL: URL?
    var movieTitle: String?
    var credit: Int?
    var overView: String?
    var creditList: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "출연/제작"
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        
        creditTableView.delegate = self
        creditTableView.dataSource = self
        creditTableView.rowHeight = 100
        creditTableView.sectionHeaderHeight = 40
        creditTableView.sectionFooterHeight = 0
        creditTableView.backgroundColor = .systemBackground
        
        let nib = UINib(nibName: CreditTableViewCell.identifier, bundle: nil)
        let nib2 = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        creditTableView.register(nib, forCellReuseIdentifier: CreditTableViewCell.identifier)
        creditTableView.register(nib2, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        
        guard let credit = credit else { return }
        print("Credit: \(credit)")
        
        callRequestCreditAPI(mediaType: .movie, credit: credit)
        
        guard let movieTitle = movieTitle else { return }
        guard let backURL = backURL else { return }
        guard let posterURL = posterURL else { return }
        
        print(movieTitle)
        print(backURL)
        print(posterURL)
        
        movieTitleLabel.text = movieTitle
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        backImageView.kf.setImage(with: backURL)
        backImageView.contentMode = .scaleAspectFill
        posterImageView.kf.setImage(with: posterURL)
        
    }
    
    func callRequestCreditAPI(mediaType: MediaType, credit: Int) {
        TMDBAPIManager.shared.requestCreditAPI(mediaType: mediaType, credit: credit) { json in
//            print(json)
            
            let cast = json["cast"].arrayValue
            print(cast)
            
            for item in cast {
                let name = item["name"].stringValue
                let profilePath = item["profile_path"].stringValue
                let character = item["character"].stringValue
                
                guard let profileURL = URL(string: "https://image.tmdb.org/t/p/original\(profilePath)") else { return }
                
                let data = Cast(name: name, profileURL: profileURL, character: character)
                
                self.creditList.append(data)
            }
            
            self.creditTableView.reloadData()
            print(self.creditList)
            
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
        return section == 0 ? 1 : creditList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
            
            cell.overviewLabel.text = overView
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as? CreditTableViewCell else { return UITableViewCell() }
            
            DispatchQueue.main.async {
                cell.profileImageView.kf.setImage(with: self.creditList[indexPath.row].profileURL)
                cell.nameLabel.text = self.creditList[indexPath.row].name
                cell.characterLabel.text = self.creditList[indexPath.row].character
            }
            
            cell.selectionStyle = .none
            return cell
        }
        
        
        
        
    }
    
}
