//
//  NextViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/09/01.
//

import UIKit

class NextViewController: BaseViewController {
    
    var nextView = NextView()
    var navigationTitle: String?
    
    // Protocol 값 전달 2.
    var delegate: InstaDataDelegate?
    
    // Closure 1.
    var completionHandler: ((String, String) -> Void)?
    
    override func loadView() {
        super.loadView()
        self.view = nextView
    }
    
    override func viewDidLoad() {
        guard let navigationTitle = navigationTitle else { return }
        title = navigationTitle
        nextView.titleLabel.text = "\(navigationTitle):"
        nextView.textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let navigationTitle = navigationTitle else { return }
        guard let text = nextView.textField.text else { return }
        
        // Protocol 값 전달 3.
        delegate?.receiveData(title: navigationTitle, value: text)
        
        // Closure 2.
        completionHandler?(navigationTitle, text)
        
        // Notification 2.
        NotificationCenter.default.post(name: Notification.Name("ReceiveValue"), object: nil, userInfo: ["title": navigationTitle, "value": text])
        
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
}

