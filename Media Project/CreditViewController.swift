//
//  CreditViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/13.
//

import UIKit

struct Cast {
    var gender: Int
    var department: String
    var name: String
    var popularity: Double
    var profileURL: URL
    var character: String
}

class CreditViewController: UIViewController {
    
    @IBOutlet var creditTableView: UITableView!
    
    var credit: Int?
    var creditList: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creditTableView.delegate = self
        creditTableView.dataSource = self
        creditTableView.rowHeight = 150
        
        guard let credit = credit else { return }
        print("Credit: \(credit)")
        
        callRequest(mediaType: .movie, credit: credit)
        
        
    }
    
    func callRequest(mediaType: MediaType, credit: Int) {
        TMDBAPIManager.shared.requestCreditAPI(mediaType: mediaType, credit: credit) { json in
//            print(json)
            
            let cast = json["cast"].arrayValue
            print(cast)
            
            for item in cast {
                let gender = item["gender"].intValue
                let department = item["known_for_department"].stringValue
                let name = item["name"].stringValue
                let popularity = item["popularity"].doubleValue
                let profilePath = item["profile_path"].stringValue
                let character = item["character"].stringValue
                
                guard let profileURL = URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)") else { return }
                
                let data = Cast(gender: gender, department: department, name: name, popularity: popularity, profileURL: profileURL, character: character)
                
                self.creditList.append(data)
            }
            
            self.creditTableView.reloadData()
            print(self.creditList)
            
        }
    }

}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditTableViewCell.identifier) as? CreditTableViewCell else { return UITableViewCell() }
        
        var gender = ""
        if creditList[indexPath.row].gender == 1 {
            gender = "Female"
        } else {
            gender = "Male"
        }
        
        cell.profileImageView.kf.setImage(with: creditList[indexPath.row].profileURL)
        cell.nameLabel.text = "Name: \(creditList[indexPath.row].name)"
        cell.genderLabel.text = "Gender: \(gender)"
        cell.departmentLabel.text = "Department: \(creditList[indexPath.row].department)"
        cell.popularityLabel.text = "Popularity: \(creditList[indexPath.row].popularity)"
        cell.characterLabel.text = "Character: \(creditList[indexPath.row].character)"
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
