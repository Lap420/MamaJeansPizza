import UIKit

class HomePageContainerController: UIViewController {
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private let homepageVC = HomePageController()
    private lazy var homepageNavigationVC = UINavigationController(rootViewController: homepageVC)
    private var mainMenuVC: MainMenuController?
    private var willMainMenuAppear = true
}

// MARK: - Private methods
private extension HomePageContainerController {
    func initialize() {
        homepageVC.didMainMenuButtonTapped = { [weak self] in
            self?.toggleMainMenu()
        }
        addChild(homepageNavigationVC)
        view.addSubview(homepageNavigationVC.view)
//        homepageNavigationVC.view.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        homepageNavigationVC.didMove(toParent: self)
        homepageNavigationVC.view.layer.masksToBounds = false
        homepageNavigationVC.view.layer.shadowOffset = CGSize(width: -1, height: 1)
        homepageNavigationVC.view.layer.shadowRadius = 5
    }
    
    func toggleMainMenu() {
        if willMainMenuAppear {
            addMainMenuVC()
        }
        willMainMenuAppear = !willMainMenuAppear
        showMenuViewController(!willMainMenuAppear)
    }
    
    func addMainMenuVC() {
        mainMenuVC = MainMenuController()
        guard let mainMenuVC = mainMenuVC else { return }
        addChild(mainMenuVC)
        view.insertSubview(mainMenuVC.view, at: 0)
        mainMenuVC.didMove(toParent: self)
        homepageNavigationVC.view.layer.shadowOpacity = 0.3
    }
    
    func removeMainMenuVC() {
        guard let mainMenuVC = self.mainMenuVC else { return }
        mainMenuVC.willMove(toParent: nil)
        mainMenuVC.view.removeFromSuperview()
        mainMenuVC.removeFromParent()
        homepageNavigationVC.view.layer.shadowOpacity = 0
    }
    
    func showMenuViewController(_ willMainMenuAppear: Bool) {
        if willMainMenuAppear {
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0,
                options: .curveEaseInOut,
                animations: {
                    guard let view = self.homepageNavigationVC.view else { return }
                    view.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                    view.frame.origin.x = view.frame.width * 0.85
                },
                completion: { _ in
                    
                    
                }
            )
        } else {
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0,
                options: .curveEaseInOut,
                animations: {
                    guard let view = self.homepageNavigationVC.view else { return }
                    view.transform = .identity
                    view.frame.origin.x = 0
                },
                completion: { _ in
                    self.removeMainMenuVC()
                }
            )
        }
    }
}
