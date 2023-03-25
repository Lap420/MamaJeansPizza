//
//  HomePageViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 23.03.2023.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private lazy var mainPageView = HomePageView()
    //private var mainPageModel = MainPageModel()
    private lazy var bonusBalanceLabel = UILabel()
}

// MARK: Private methods
private extension HomePageViewController {
    func initialize() {
        view = mainPageView
        mainPageView.scrollView.delegate = self
        configureNavigationBar()

        
//        checkIsFirstLaunch()
//        UserDefaultsManager.loadMainPageData(&mainPageModel)
//        initFieldsState()
//        updateElements()
        
//        initDelegates()
//        initButtonTargets()
        
//        view.addSubview(mainPageView)
//        mainPageView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.leading.trailing.equalToSuperview().inset(UIConstants.contentHorizontalInset)
//        }
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = UIConstants.mamaGreenColor
        navigationController?.navigationBar.barTintColor = UIConstants.mamaGreenColor
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let settingsButton = UIBarButtonItem(
            image: .init(systemName: "line.horizontal.3"),
            style: .plain,
            target: nil,
            action: #selector(settingsButtonTapped))
        navigationItem.leftBarButtonItem = settingsButton
        
        let navigationTitleView = UIView()
        let navigationTitleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
            label.text = "MAMAJEANS"
            label.font = .systemFont(ofSize: 28, weight: .heavy)
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        navigationTitleView.addSubview(navigationTitleLabel)
        navigationTitleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        navigationItem.titleView = navigationTitleLabel
        
        let bonusBalanceStack = UIStackView()
        bonusBalanceLabel.text = "0"
        bonusBalanceLabel.textColor = .white
        let bonusBalanceImage = UIImageView(image: .init(named: "pizza_icon"))
        bonusBalanceStack.addArrangedSubview(bonusBalanceLabel)
        bonusBalanceStack.addArrangedSubview(bonusBalanceImage)
        bonusBalanceImage.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        let bonusBalance = UIBarButtonItem(customView: bonusBalanceStack)
        navigationItem.rightBarButtonItem = bonusBalance
    }
    
    @objc
    func settingsButtonTapped() {
        print("Settings button tapped")
    }
}

extension HomePageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let titleView = navigationItem.titleView else { return }
        let yOffset = scrollView.contentOffset.y
        let maxMovement: CGFloat = 20
        let progress = yOffset < maxMovement ? yOffset / maxMovement : 1
        let movement = maxMovement * progress - 20
        titleView.transform = CGAffineTransform(translationX: 0, y: -movement)
        let alpha = pow(0.95, scrollView.contentOffset.y)
        titleView.alpha = alpha
    }
}
