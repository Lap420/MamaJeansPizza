import UIKit

class HomePageContainerController: UIViewController {
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private let mainNavigationVC = MainNavigationController()
    private var mainMenuVC: MainMenuController?
    private var willMainMenuAppear = true
}

// MARK: - Private methods
private extension HomePageContainerController {
    func initialize() {
        if let homepageVC = mainNavigationVC.viewControllers.first as? HomePageController {
            homepageVC.didToggleMainMenu = { [weak self] in
                self?.toggleMainMenu()
            }
        }
        addChild(mainNavigationVC)
        view.addSubview(mainNavigationVC.view)
        mainNavigationVC.didMove(toParent: self)
    }
    
    func toggleMainMenu() {
        if willMainMenuAppear {
            addMainMenuVC()
            addHomepageViewShadow()
        }
        willMainMenuAppear = !willMainMenuAppear
        showMainMenuVC(!willMainMenuAppear)
    }
    
    func addHomepageViewShadow() {
        mainNavigationVC.view.layer.shadowOpacity = 0.3
    }
    
    func removeHomepageViewShadow() {
        mainNavigationVC.view.layer.shadowOpacity = 0.0
    }
    
    func addMainMenuVC() {
        mainMenuVC = MainMenuController()
        guard let mainMenuVC = mainMenuVC else { return }
        addChild(mainMenuVC)
        view.insertSubview(mainMenuVC.view, at: 0)
        mainMenuVC.didMove(toParent: self)
        mainMenuVC.view.frame = view.frame
    }
    
    func removeMainMenuVC() {
        guard let mainMenuVC = self.mainMenuVC else { return }
        mainMenuVC.willMove(toParent: nil)
        mainMenuVC.view.removeFromSuperview()
        mainMenuVC.removeFromParent()
    }
    
    func moveMainNavigationControllerRight() {
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                guard let view = self.mainNavigationVC.view else { return }
                view.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                view.frame.origin.x = view.frame.width * 0.85
            }
        )
    }
    
    func moveMainNavigationControllerBack() {
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                guard let view = self.mainNavigationVC.view else { return }
                view.transform = .identity
                view.frame.origin.x = 0
            },
            completion: { _ in
                self.removeMainMenuVC()
                self.removeHomepageViewShadow()
            }
        )
    }
    
    func decreaseMainMenuVC() {
        guard let mainMenuVC = mainMenuVC else { return }
        mainMenuVC.view.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                guard let mainMenuVC = self.mainMenuVC else { return }
                mainMenuVC.view.transform = .identity
            }
        )
    }
    
    func increaseMainMenuVC() {
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0,
            options: .curveEaseInOut,
            animations: {
                guard let mainMenuVC = self.mainMenuVC else { return }
                mainMenuVC.view.transform = CGAffineTransform(scaleX: 1.75, y: 1.75)
            }
        )
    }
    
    func showMainMenuVC(_ willMainMenuAppear: Bool) {
        if willMainMenuAppear {
            moveMainNavigationControllerRight()
            decreaseMainMenuVC()
        } else {
            moveMainNavigationControllerBack()
            increaseMainMenuVC()
        }
    }
}
