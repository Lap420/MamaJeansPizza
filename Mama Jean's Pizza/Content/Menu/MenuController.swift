import UIKit

// TODO: Move model to model file
// TODO: Add a header for the collection
// TODO: Add basket button
// TODO: Remove UIKit from MenuUploader

class MenuController: UIViewController {
    // MARK: Public properties
    var menu = [(id: String, name: String)]()
    var menuImages = [String: UIImage]()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    // MARK: - Private properties
    private var menuView = MenuView()
}

// MARK: Private methods
private extension MenuController {
    func initialize() {
        view = menuView
        self.title = "Menu"
        prepareMenu()
        initCollectionsDelegateAndSource()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
        
    func prepareMenu() {
        MenuManager.shared.menu?.forEach { menuGroup in
            menu.append((menuGroup.id, menuGroup.name))
        }
    }
    
    func initCollectionsDelegateAndSource() {
        menuView.menuCollectionView.register(
            MenuCell.self,
            forCellWithReuseIdentifier: MenuCell.idetifier
        )
        menuView.menuCollectionView.delegate = self
        menuView.menuCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource
extension MenuController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return menu.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCell.idetifier,
            for: indexPath
        ) as! MenuCell
        cell.configure(
            name: menu[indexPath.item].name,
            image: MenuManager.shared.menuImages[menu[indexPath.item].id]
        )
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MenuController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let nextVC = ItemsController()
        nextVC.choosenMenuGroupId = menu[indexPath.row].id
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
