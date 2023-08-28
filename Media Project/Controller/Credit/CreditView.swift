//
//  CreditView.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/28.
//

import UIKit

class CreditView: BaseView {
    
    let headerView = {
        let view = UIView()
        view.backgroundColor = .systemBrown
        return view
    }()
    
    let backImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let movieTitleLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 25, weight: .bold)
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        return view
    }()
    
    let creditTableView = {
        let view = UITableView()
        view.sectionHeaderHeight = 40
        view.sectionFooterHeight = 0
        view.backgroundColor = .systemBackground
        // 아래 코드는 테이블 전체가 변하므로
        // 섹션별로 바꿀 수 있는 코드는 없는지 알아보자
        view.separatorStyle = .none
//        view.separatorColor = .clear
        
        view.register(CreditTableViewCell.self, forCellReuseIdentifier: CreditTableViewCell.identifier)
        view.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        view.register(OverviewButtonTableViewCell.self, forCellReuseIdentifier: OverviewButtonTableViewCell.identifier)
        return view
    }()
    
    override func configureView() {
        super.configureView()
        
        addSubview(creditTableView)
        
        creditTableView.addSubview(headerView)
        
        [backImageView, movieTitleLabel, posterImageView].forEach {
            headerView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        creditTableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        // 헤더뷰만 확인해보자!
        headerView.snp.makeConstraints {
            $0.top.equalTo(creditTableView.bounds.width)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(220)
        }
    }
}
