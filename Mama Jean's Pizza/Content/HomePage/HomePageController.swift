// TODO: Finish basket page items feature
// TODO: Finish basket page add items count check if basket is empty
// TODO: Finish basket page
// TODO: Finish Order Placed page
// TODO: Send orders to Syrve
// TODO: Save created orders to history
// TODO: Implement Repeat order feature

import UIKit

class HomePageController: UIViewController {
    // MARK: - Public properties
    var didToggleMainMenu: (() -> ())?
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Private properties
    private let homePageView = HomePageView()
    private var homePageModel = HomePageModel()
    private let balanceView = BalanceView()
    private var tapGesture: UITapGestureRecognizer?
}

// MARK: - Private methods
private extension HomePageController {
    func initialize() {
        view = homePageView
        self.title = "Homepage"
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(homepageViewTapped))
        tapGesture!.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture!)
        homePageView.scrollView.delegate = self
        configureNavigationBar()
        initCollections()
        initButtonTargets()
        checkIsFirstLaunch()
        updateBalanceLabel()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateBalanceLabel),
            name: Notification.Name(rawValue: "BalanceUpdated"),
            object: nil
        )
//        DispatchQueue.global(qos: .utility).async { _ = MenuManager.shared  }
    }
    
    func configureNavigationBar() {
        // MARK: Left navbar
        let settingsButton = UIBarButtonItem(
            image: .init(systemName: "line.horizontal.3"),
            style: .plain,
            target: self,
            action: #selector(mainMenuButtonTapped)
        )
        navigationItem.leftBarButtonItem = settingsButton
        
        // MARK: Title navbar
        let navigationTitleView = UIView()
        let navigationTitleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
            label.text = "MAMAJEANS"
            label.font = .systemFont(
                ofSize: 28,
                weight: .heavy
            )
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        navigationTitleView.addSubview(navigationTitleLabel)
        navigationTitleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        navigationItem.titleView = navigationTitleLabel
        
        // MARK: Right navbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: balanceView)
    }
    
    func initCollectionsDelegateAndSource() {
        homePageView.dealsCollectionView.register(
            HomePageCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        homePageView.dealsCollectionView.delegate = self
        homePageView.dealsCollectionView.dataSource = self
        homePageView.rewardsCollectionView.register(
            HomePageCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        homePageView.rewardsCollectionView.delegate = self
        homePageView.rewardsCollectionView.dataSource = self
        homePageView.pointsCollectionView.register(
            HomePageCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        homePageView.pointsCollectionView.delegate = self
        homePageView.pointsCollectionView.dataSource = self
    }
    
    func disableCollectionsInteraction() {
        homePageView.dealsCollectionView.isUserInteractionEnabled = false
        homePageView.rewardsCollectionView.isUserInteractionEnabled = false
        homePageView.pointsCollectionView.isUserInteractionEnabled = false
    }
    
    func enableCollectionsInteraction() {
        homePageView.dealsCollectionView.isUserInteractionEnabled = true
        homePageView.rewardsCollectionView.isUserInteractionEnabled = true
        homePageView.pointsCollectionView.isUserInteractionEnabled = true
    }
    
    func getHomePageData(
        collectionType: HomepageCollectionType,
        group: DispatchGroup
    ) {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            FirebaseManager.shared.getHomepageData(
                collection: collectionType.rawValue
            ) { [weak self] data in
                guard data.count > 0 else { group.leave(); return }
                switch collectionType {
                case .deals:
                    self?.homePageModel.deals = data
                case .rewards:
                    self?.homePageModel.rewards = data
                case .points:
                    self?.homePageModel.points = data
                }
                group.leave()
            }
        }
    }
    
    func uploadCollectionsData() {
        let group = DispatchGroup()
        getHomePageData(collectionType: .deals, group: group)
        getHomePageData(collectionType: .rewards, group: group)
        getHomePageData(collectionType: .points, group: group)
        group.notify(queue: .main) { [weak self] in
            self?.homePageView.dealsCollectionView.reloadData()
            self?.homePageView.rewardsCollectionView.reloadData()
            self?.homePageView.pointsCollectionView.reloadData()
            self?.enableCollectionsInteraction()
        }
    }
    
    func initCollections() {
        initCollectionsDelegateAndSource()
//        disableCollectionsInteraction()
//        uploadCollectionsData()
    }
    
    func initButtonTargets() {
        homePageView.orderNowButton.addTarget(
            self,
            action: #selector(orderNowButtonTapped),
            for: .touchUpInside
        )
        homePageView.repeatOrderButton.addTarget(
            self,
            action: #selector(repeatOrderButtonTapped),
            for: .touchUpInside
        )
        homePageView.rateButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside
        )
        homePageView.instagramButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside
        )
        homePageView.facebookButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside
        )
        homePageView.linkedinButton.addTarget(
            self,
            action: #selector(openLapTelegram),
            for: .touchUpInside
        )
    }
    
    func checkIsFirstLaunch() {
        let isFirstLaunch = UserDefaultsManager.loadIsFirstLaunch()
//        let isFirstLaunch = true
        if isFirstLaunch {
            UserDefaultsManager.saveIsFirstLaunch()
            let nextVC = IntroPageController(
                transitionStyle: .scroll,
                navigationOrientation: .horizontal,
                options: nil)
            nextVC.modalPresentationStyle = .fullScreen
            present(nextVC, animated: true)
        }
    }
    
    func createNewOrder() {
        let nextVC = ChooseAStoreController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc
    func homepageViewTapped() {
        guard homePageView.isMainMenuOpen else { return }
        didToggleMainMenu?()
        homePageView.isMainMenuOpen = !homePageView.isMainMenuOpen
    }
    
    @objc
    func mainMenuButtonTapped() {
        didToggleMainMenu?()
        homePageView.isMainMenuOpen = !homePageView.isMainMenuOpen
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
        let balance = UserDefaultsManager.loadBalance()
        balanceView.bonusBalanceLabel.text = "\(balance)"
    }
}

// MARK: - UIScrollViewDelegate
extension HomePageController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == homePageView.scrollView else { return }
        guard let titleView = navigationItem.titleView else { return }
        let alpha = pow(0.95, scrollView.contentOffset.y)
        titleView.alpha = alpha
    }
}

// MARK: - UICollectionViewDataSource
extension HomePageController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch collectionView {
        case homePageView.dealsCollectionView:
            return homePageModel.deals.count
        case homePageView.rewardsCollectionView:
            return homePageModel.rewards.count
        case homePageView.pointsCollectionView:
            return homePageModel.points.count
        default:
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch collectionView {
        case homePageView.dealsCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
            ) as! HomePageCell
            var image: UIImage? = nil
            if let imageData = homePageModel.deals[indexPath.row].imageData {
                image = UIImage(data: imageData)
            }
            cell.configure(image: image)
            return cell
        case homePageView.rewardsCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
            ) as! HomePageCell
            var image: UIImage? = nil
            if let imageData = homePageModel.rewards[indexPath.row].imageData {
                image = UIImage(data: imageData)
            }
            cell.configure(image: image)
            return cell
        case homePageView.pointsCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
            ) as! HomePageCell
            var image: UIImage? = nil
            if let imageData = homePageModel.points[indexPath.row].imageData {
                image = UIImage(data: imageData)
            }
            cell.configure(image: image)
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomePageController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        switch collectionView {
        case homePageView.dealsCollectionView:
            let nextVC = DealDescriptionController()
            nextVC.didOrderButtonClicked = { [weak self] in
                self?.createNewOrder()
            }
            nextVC.dealName = homePageModel.deals[indexPath.row].name
            nextVC.dealDescription = homePageModel.deals[indexPath.row].description
            var image: UIImage? = nil
            if let imageData = homePageModel.deals[indexPath.row].imageData {
                image = UIImage(data: imageData)
            }
            nextVC.image = image
            present(nextVC, animated: true)
        case homePageView.rewardsCollectionView:
            createNewOrder()
        case homePageView.pointsCollectionView:
            createNewOrder()
        default:
            return
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomePageController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch collectionView {
        case homePageView.dealsCollectionView:
            return HomePageView.CollectionSizes.dealsSize
        case homePageView.rewardsCollectionView:
            return HomePageView.CollectionSizes.rewardsSize
        case homePageView.pointsCollectionView:
            return HomePageView.CollectionSizes.pointsSize
        default:
            return CGSize(width: 100, height: 100)
        }
    }
}
