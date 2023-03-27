//
//  HomePageViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 23.03.2023.
//

// TODO: Make HomePageModel UI independent
// TODO: Add new screen on Deal choosing
// TODO: Add new screen for Introduction

// TODO: Move model to another file
// TODO: Check Firebase connection for the model
// TODO: Finish UICollectionViewDelegate
// TODO: Finish checkIsFirstLaunch
// TODO: Make collection sizes equals screen width

import UIKit

class HomePageViewController: UIViewController {
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateBalanceLabel),
                                               name: Notification.Name(rawValue: "BalanceUpdated"),
                                               object: nil)
        updateBalanceLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainPageView.updateConstraintsForBigScreens()
    }
    
    // MARK: - Private properties
    private var mainPageView = HomePageView()
    //private var mainPageModel = MainPageModel()
    private var bonusBalanceLabel = UILabel()
    private var deals: [HomepageData] = [HomepageData(name: "1",
                                                      dealDescription: "2",
                                                      image: UIImage(named: "No_Image")!),
                                         HomepageData(name: "1",
                                                      dealDescription: "2",
                                                      image: UIImage(named: "No_Image")!),
                                         HomepageData(name: "1",
                                                      dealDescription: "2",
                                                      image: UIImage(named: "No_Image")!)]
    private var rewards: [HomepageData] = [HomepageData(name: "1",
                                                        dealDescription: "2",
                                                        image: UIImage(named: "No_Image")!),
                                           HomepageData(name: "1",
                                                        dealDescription: "2",
                                                        image: UIImage(named: "No_Image")!),
                                           HomepageData(name: "1",
                                                        dealDescription: "2",
                                                        image: UIImage(named: "No_Image")!)]
    private var points: [HomepageData] = [HomepageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!),
                                          HomepageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!),
                                          HomepageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!)]
}

// MARK: Private methods
private extension HomePageViewController {
    func initialize() {
        view = mainPageView
        mainPageView.scrollView.delegate = self
        configureNavigationBar()
        initCollections()
        initButtonTargets()
        checkIsFirstLaunch()
        //DispatchQueue.global(qos: .utility).async { _ = MenuManager.shared  }
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = GlobalUIConstants.mamaGreenColor
        navigationController?.navigationBar.barTintColor = GlobalUIConstants.mamaGreenColor
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let settingsButton = UIBarButtonItem(
            image: .init(systemName: "line.horizontal.3"),
            style: .plain,
            target: self,
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
    
    func initCollectionsDelegateAndSource() {
        mainPageView.dealsCollectionView.register(DealCell.self, forCellWithReuseIdentifier: "cell")
        mainPageView.dealsCollectionView.delegate = self
        mainPageView.dealsCollectionView.dataSource = self
        mainPageView.rewardsCollectionView.register(RewardsCell.self, forCellWithReuseIdentifier: "cell")
        mainPageView.rewardsCollectionView.delegate = self
        mainPageView.rewardsCollectionView.dataSource = self
        mainPageView.pointsCollectionView.register(PointsCell.self, forCellWithReuseIdentifier: "cell")
        mainPageView.pointsCollectionView.delegate = self
        mainPageView.pointsCollectionView.dataSource = self
    }
    
    func getHomePageData(collectionType: HomepageCollectionType, group: DispatchGroup) {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            FirebaseManager.shared.getHomepageData(collection: collectionType.rawValue) { [weak self] data in
                guard data.count > 0 else { group.leave(); return }
                switch collectionType {
                case .deals:
                    self?.deals = data
                case .rewards:
                    self?.rewards = data
                case .points:
                    self?.points = data
                }
                group.leave()
            }
        }
    }
    
    func initCollections() {
        initCollectionsDelegateAndSource()
        let group = DispatchGroup()
        getHomePageData(collectionType: .deals, group: group)
        getHomePageData(collectionType: .rewards, group: group)
        getHomePageData(collectionType: .points, group: group)
        group.notify(queue: .main) { [self] in
            mainPageView.dealsCollectionView.reloadData()
            mainPageView.rewardsCollectionView.reloadData()
            mainPageView.pointsCollectionView.reloadData()
        }
    }
    
    func initButtonTargets() {
        mainPageView.orderNowButton.addTarget(
            self,
            action: #selector(orderNowButtonTapped),
            for: .touchUpInside)
        mainPageView.repeatOrderButton.addTarget(
            self,
            action: #selector(repeatOrderButtonTapped),
            for: .touchUpInside)
        mainPageView.rateButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside)
        mainPageView.instagramButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside)
        mainPageView.facebookButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside)
        mainPageView.linkedinButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside)
    }
    
    func checkIsFirstLaunch() {
//        let isFirstLaunch = UserDefaultsManager.loadIsFirstLaunch()
//        if isFirstLaunch {
//            UserDefaultsManager.saveIsFirstLaunch()
//            UserDefaultsManager.saveSettingsPageRounding(2)
//        }
    }
    
    func createNewOrder() {
        print("New order creation")
        
    }
    
    @objc
    func settingsButtonTapped() {
        let alert = AlertManager.featureIsNotImplementedAlert(feature: "User settings")
        present(alert, animated: true)
    }
    
    @objc
    func orderNowButtonTapped() {
        createNewOrder()
    }
    
    @objc
    func repeatOrderButtonTapped() {
        let alert = AlertManager.featureIsNotImplementedAlert(feature: "Repeat order")
        present(alert, animated: true)
    }
    
    @objc
    func openLapTelegram() {
        if let url = URL(string: "https://t.me/lap42") {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc
    func updateBalanceLabel() {
        bonusBalanceLabel.text = "\(BalanceObserver.shared.balance)"
    }
}

// MARK: - UIScrollViewDelegate
extension HomePageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == mainPageView.scrollView else { return }
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

// MARK: - UICollectionViewDataSource
extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainPageView.dealsCollectionView:
            return deals.count
        case mainPageView.rewardsCollectionView:
            return rewards.count
        case mainPageView.pointsCollectionView:
            return points.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainPageView.dealsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as! DealCell
            cell.configure(image: deals[indexPath.row].image)
            return cell
        case mainPageView.rewardsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as! RewardsCell
            cell.configure(image: rewards[indexPath.row].image)
            return cell
        case mainPageView.pointsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as! PointsCell
            cell.configure(image: points[indexPath.row].image)
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomePageViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView {
////        case mainPageView.dealsCollectionView:
////            if let dealVC = storyboard?.instantiateViewController(withIdentifier: "dealVC") as? DealViewController {
////                dealVC.homePageDelegate = self
////                dealVC.dealName = deals[indexPath.row].name
////                dealVC.dealDescription = deals[indexPath.row].dealDescription
////                dealVC.image = deals[indexPath.row].image
////                present(dealVC, animated: true)
////            }
//        case mainPageView.rewardsCollectionView:
//            createNewOrder()
//        case mainPageView.pointsCollectionView:
//            createNewOrder()
//        default:
//            return
//        }
//    }
}

// MARK: - UIScrollViewDelegate
extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case mainPageView.dealsCollectionView:
            return HomePageCollectionSizes.dealsSize
        case mainPageView.rewardsCollectionView:
            return HomePageCollectionSizes.rewardsSize
        case mainPageView.pointsCollectionView:
            return HomePageCollectionSizes.pointsSize
        default:
            return CGSize(width: 100, height: 100)
        }
        
    }
}

// MARK: - HomePageDelegate protocol
protocol HomePageDelegate {
    func updatePointsLabel()
    func goToNewOrder()
}
