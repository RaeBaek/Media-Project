//
//  OnboardingViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/25.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    let infoImage = {
        let view = UIImageView()
        view.image = UIImage(named: "FirstImage")
        return view
    }()
    
    let listLabel = {
        let view = UILabel()
        view.text = "1. 리스트 버튼으로 여러 카테고리를 선택할 수 있습니다."
        view.textColor = .red
        view.font = .systemFont(ofSize: 13, weight: .regular)
        return view
    }()
    
    let listCircle = {
        let view = CheckUIView()
        return view
    }()
    
    let searchLabel = {
        let view = UILabel()
        view.text = "2. 검색 버튼으로 영화를 검색할 수 있습니다."
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textColor = .red
        return view
    }()
    
    let searchCircle = {
        let view = CheckUIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        [infoImage, listLabel, listCircle, searchLabel, searchCircle].forEach {
            view.addSubview($0)
        }
        
        infoImage.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        listLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(3)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        listCircle.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.top.equalTo(listLabel.snp.bottom).offset(0)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(27)
        }
        
        searchCircle.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        
        searchLabel.snp.makeConstraints {
            $0.top.equalTo(searchCircle.snp.bottom).offset(5)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        
    }
    
}

class SecondViewController: UIViewController {
    
    let infoImage = {
        let view = UIImageView()
        view.image = UIImage(named: "FirstImage")
        return view
    }()
    
    let box = {
        let view = UIView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let boxLabel = {
        let label = UILabel()
        label.text = "3. 영화의 상세정보가 궁금하다면 클릭해보세요!"
        label.textColor = .red
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        [infoImage, box, boxLabel].forEach {
            view.addSubview($0)
        }
        
        infoImage.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        box.snp.makeConstraints {
            $0.centerY.equalTo(infoImage).multipliedBy(0.98)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(box.snp.width)
        }
        
        boxLabel.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.bottom.equalTo(box.snp.top).offset(-10)
        }
    }
    
}

class ThirdViewController: UIViewController {
    
    let infoImage = {
        let view = UIImageView()
        view.image = UIImage(named: "SecondImage")
        return view
    }()
    
    let startButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    let box = {
        let view = UIView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let boxLabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "4. 버튼을 클릭해 더 많은 줄거리를 확인할 수 있습니다."
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        [infoImage, startButton, box, boxLabel].forEach {
            view.addSubview($0)
        }
        
        infoImage.snp.makeConstraints {
            $0.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(infoImage.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview()
        }
        
        box.snp.makeConstraints {
            $0.horizontalEdges.equalTo(infoImage).inset(20)
            $0.height.equalTo(30)
            $0.centerY.equalToSuperview().multipliedBy(1.05)
        }
        
        boxLabel.snp.makeConstraints {
            $0.top.equalTo(box.snp.bottom).offset(10)
            $0.centerX.equalTo(box.snp.centerX)
        }
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: TMDBViewController.identifier) as? TMDBViewController else { return }
        
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}

class OnboardingViewController: UIPageViewController {
    
    var list: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        view.backgroundColor = .lightGray
        delegate = self
        dataSource = self
        
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
    }
    
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        
        return nextIndex >= list.count ? nil : list[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else { return 0 }
        return index
    }
    
}
