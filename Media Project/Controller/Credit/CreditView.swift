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
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let backImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
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
//        view.separatorStyle = .none
//        view.separatorColor = .clear
        
        view.register(CreditTableViewCell.self, forCellReuseIdentifier: CreditTableViewCell.identifier)
        view.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        view.register(OverviewButtonTableViewCell.self, forCellReuseIdentifier: OverviewButtonTableViewCell.identifier)
        
        return view
        
    }()
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func configureView() {
        super.configureView()
        
        addSubview(creditTableView)
        
        // 테이블뷰 최상단에 헤더뷰를 추가해줄 때에는
        // tableView.addSubview() 가 아닌 tableView.tableHeaderView 를 사용하면 된다.
        creditTableView.tableHeaderView = headerView
        
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
        // tableHeaderView의 너비는 tableView의 너비를 따라가는데
        // tableView가 초기화되기 전에 너비가 잡히므로 단순히 equalToSuperview()로 선언하면 너비가 0이 되는 것 같다.
        // 그러므로 self의 너비로 잡아주어야한다.
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(self.bounds.width)
            $0.height.equalTo(220)
        }
        
        backImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(30)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(100)
        }
        
    }
}
