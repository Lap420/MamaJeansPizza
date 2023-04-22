import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public properties
    var window: UIWindow?

    // MARK: - Public methods
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        let rootVC = HomePageContainerController()
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

