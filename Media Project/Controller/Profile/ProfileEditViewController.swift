//
//  ProfileEditViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/09/01.
//

import UIKit

// Protocol 값 전달 1.
protocol InstaDataDelegate {
    func receiveData(title: String, value: String)
}

class ProfileEditViewController: BaseViewController {
    
    let mainView = ProfileEditView()
    
    var navigationTitle: String?
    
//    var myUser = User(name: "", nickname: "", gender: "", introduce: "", link: "")
    
    var titleList = ["이름", "사용자 이름", "성별 대명사", "소개", "링크", "성별"]
    var myUser = ["", "", "", "", "", ""]
    
    var uiEdgeInsetList = [
        UIEdgeInsets(top: 0, left: 132, bottom: 0, right: 16),
        UIEdgeInsets(top: 0, left: 132, bottom: 0, right: 16),
        UIEdgeInsets(top: 0, left: 132, bottom: 0, right: 16),
        UIEdgeInsets(top: 0, left: 132, bottom: 0, right: 16),
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    ]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
//        navigationController?.navigationBar.topItem?.title = ""
        
//        navigationItem.backBarButtonItem?.tintColor = .black
        
        mainView.profileTableView.delegate = self
        mainView.profileTableView.dataSource = self
        
        // Notification 1.
        NotificationCenter.default.addObserver(self, selector: #selector(receiveValueNotificationObserver), name: NSNotification.Name("ReceiveValue"), object: nil)
    }
    
    @objc func receiveValueNotificationObserver(notification: NSNotification) {
        print(#function)
        
        guard let title = notification.userInfo?["title"] as? String else { return }
        guard let value = notification.userInfo?["value"] as? String else { return }
        
        print("NotificationCenter Value Receive", value)
        switch title {
        case "이름": self.myUser[0] = value
        case "사용자 이름": self.myUser[1] = value
        case "성별 대명사": self.myUser[2] = value
        case "소개": self.myUser[3] = value
        case "링크": self.myUser[4] = value
        case "성별": self.myUser[5] = value
        default:
            return
        }
        self.mainView.profileTableView.reloadData()
    
    }
    
    override func configureView() {
        super.configureView()
        title = "프로필 편집"
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
    }
}

extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 170
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageTableViewCell") as? ProfileImageTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as? ProfileTableViewCell else { return UITableViewCell() }
            
            cell.titleLabel.text = titleList[indexPath.row]
            cell.titleTextField.placeholder = titleList[indexPath.row]
            cell.titleTextField.text = myUser[indexPath.row]
            
            if titleList[indexPath.row] == "성별" || titleList[indexPath.row] == "링크" {
                cell.nextImage.isHidden = false
            } else {
                cell.nextImage.isHidden = true
            }
            
            cell.selectionStyle = .none
            cell.separatorInset = uiEdgeInsetList[indexPath.row]
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            return
        } else {
            let vc = NextViewController()
            vc.navigationTitle = titleList[indexPath.row]
            
            // Protocol
            vc.delegate = self
            
            // Closure 3.
//            vc.completionHandler = { title, value in
//                print("CompletionHandler Value Receive", value)
//                switch title {
//                case "이름": self.myUser[0] = value
//                case "사용자 이름": self.myUser[1] = value
//                case "성별 대명사": self.myUser[2] = value
//                case "소개": self.myUser[3] = value
//                case "링크": self.myUser[4] = value
//                case "성별": self.myUser[5] = value
//                default:
//                    return
//                }
//                self.mainView.profileTableView.reloadData()
//
//            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension ProfileEditViewController: InstaDataDelegate {
    func receiveData(title: String, value: String) {
        
//        print("Delegate Value Receive", value)
//        switch title {
//        case "이름": myUser[0] = value
//        case "사용자 이름": myUser[1] = value
//        case "성별 대명사": myUser[2] = value
//        case "소개": myUser[3] = value
//        case "링크": myUser[4] = value
//        case "성별": myUser[5] = value
//        default:
//            return
//        }
//        mainView.profileTableView.reloadData()
        
    }
    
}
