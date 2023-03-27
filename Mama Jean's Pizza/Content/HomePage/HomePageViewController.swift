//
//  HomePageViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 23.03.2023.
//

// TODO: Make HomePageModel UI independent
// TODO: Add new screen on Deal choosing
// TODO: Add new screen for Introduction
// TODO: Activate menu uploading

// TODO: Move model to another file

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
        homePageView.updateConstraintsForBigScreens()
    }
    
    // MARK: - Private properties
    private var homePageView = HomePageView()
    private var homePageModel = HomePageModel()
    private var bonusBalanceLabel = UILabel()
    private var deals: [HomePageData] = [HomePageData(name: "1",
                                                      dealDescription: "2",
                                                      image: UIImage(named: "No_Image")!),
                                         HomePageData(name: "1",
                                                      dealDescription: "2",
                                                      image: UIImage(named: "No_Image")!)]
    private var rewards: [HomePageData] = [HomePageData(name: "1",
                                                        dealDescription: "2",
                                                        image: UIImage(named: "No_Image")!),
                                           HomePageData(name: "1",
                                                        dealDescription: "2",
                                                        image: UIImage(named: "No_Image")!),
                                           HomePageData(name: "1",
                                                        dealDescription: "2",
                                                        image: UIImage(named: "No_Image")!)]
    private var points: [HomePageData] = [HomePageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!),
                                          HomePageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!),
                                          HomePageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!),
                                          HomePageData(name: "1",
                                                       dealDescription: "2",
                                                       image: UIImage(named: "No_Image")!)]
}

// MARK: Private methods
private extension HomePageViewController {
    func initialize() {
        view = homePageView
        homePageView.scrollView.delegate = self
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
        homePageView.dealsCollectionView.register(DealCell.self, forCellWithReuseIdentifier: "cell")
        homePageView.dealsCollectionView.delegate = self
        homePageView.dealsCollectionView.dataSource = self
        homePageView.rewardsCollectionView.register(RewardsCell.self, forCellWithReuseIdentifier: "cell")
        homePageView.rewardsCollectionView.delegate = self
        homePageView.rewardsCollectionView.dataSource = self
        homePageView.pointsCollectionView.register(PointsCell.self, forCellWithReuseIdentifier: "cell")
        homePageView.pointsCollectionView.delegate = self
        homePageView.pointsCollectionView.dataSource = self
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
            homePageView.dealsCollectionView.reloadData()
            homePageView.rewardsCollectionView.reloadData()
            homePageView.pointsCollectionView.reloadData()
        }
    }
    
    func initButtonTargets() {
        homePageView.orderNowButton.addTarget(
            self,
            action: #selector(orderNowButtonTapped),
            for: .touchUpInside)
        homePageView.repeatOrderButton.addTarget(
            self,
            action: #selector(repeatOrderButtonTapped),
            for: .touchUpInside)
        homePageView.rateButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside)
        homePageView.instagramButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside)
        homePageView.facebookButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside)
        homePageView.linkedinButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside)
    }
    
    func checkIsFirstLaunch() {
        let isFirstLaunch = UserDefaultsManager.loadIsFirstLaunch()
//        isFirstLaunch = true
        if isFirstLaunch {
            UserDefaultsManager.saveIsFirstLaunch()
            print("This is the first launch")
//            let introductionTipsPageVC = IntroductionTipsPageViewController()
//            introductionTipsPageVC.homePageDelegate = self
//            present(introductionTipsPageVC, animated: true)
        }
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
        guard scrollView == homePageView.scrollView else { return }
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
        case homePageView.dealsCollectionView:
            return deals.count
        case homePageView.rewardsCollectionView:
            return rewards.count
        case homePageView.pointsCollectionView:
            return points.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case homePageView.dealsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as! DealCell
            cell.configure(image: deals[indexPath.row].image)
            return cell
        case homePageView.rewardsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as! RewardsCell
            cell.configure(image: rewards[indexPath.row].image)
            return cell
        case homePageView.pointsCollectionView:
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case homePageView.dealsCollectionView:
            print("Some deal has been choosen")
//            let dealVC = DealViewController()
//            dealVC.homePageDelegate = self
//            dealVC.dealName = deals[indexPath.row].name
//            dealVC.dealDescription = deals[indexPath.row].dealDescription
//            dealVC.image = deals[indexPath.row].image
//            present(dealVC, animated: true)
        case homePageView.rewardsCollectionView:
            createNewOrder()
        case homePageView.pointsCollectionView:
            createNewOrder()
        default:
            return
        }
    }
}

// MARK: - UIScrollViewDelegate
extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case homePageView.dealsCollectionView:
            return HomePageCollectionSizes.dealsSize
        case homePageView.rewardsCollectionView:
            return HomePageCollectionSizes.rewardsSize
        case homePageView.pointsCollectionView:
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
