import UIKit

// TODO: Add basket button

class MenuController: UIViewController {
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        showBasketButtonIfNeeded()
    }
    
    // MARK: - Private properties
    private let menuView = MenuView()
    private let balanceView = BalanceView()
    private lazy var basketButtonView = BasketButtonView()
    private var menuModel = MenuModel()
}

// MARK: Private methods
private extension MenuController {
    func initialize() {
        view = menuView
        self.title = "Menu"
        configureNavigationBar()
        initCollectionsDelegateAndSource()
        updateBalanceLabel()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateBalanceLabel),
            name: Notification.Name(rawValue: "BalanceUpdated"),
            object: nil
        )
    }
    
    func configureNavigationBar() {
        // MARK: Right navbar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: balanceView)
    }
    
    func initCollectionsDelegateAndSource() {
        menuView.menuCollectionView.register(
            MenuCell.self,
            forCellWithReuseIdentifier: MenuCell.idetifier
        )
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.dataSource = self
    }
    
    func showBasketButtonIfNeeded() {
        
    }
    
    @objc
    func updateBalanceLabel() {
        balanceView.bonusBalanceLabel.text = "\(BalanceObserver.shared.balance)"
    }
}

// MARK: - UICollectionViewDataSource
extension MenuController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return menuModel.menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCell.idetifier,
            for: indexPath) as! MenuCell
        var image: UIImage? = nil
        let menuGroupId = menuModel.menu[indexPath.item].id
        if let imageData = menuModel.menuImages[menuGroupId] {
            image = UIImage(data: imageData)
        }
        cell.configure(
            name: menuModel.menu[indexPath.item].name,
            image: image
        )
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MenuController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let nextVC = ItemsController()
        nextVC.choosenMenuGroupId = menuModel.menu[indexPath.item].id
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
