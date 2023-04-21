import UIKit

class OrderPlacedController: UIViewController {
    // MARK: - Public properties
    var isSuccess = false
    var navController: UINavigationController?
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private lazy var orderPlacedView = OrderPlacedView()
}

// MARK: Private methods
private extension OrderPlacedController {
    func initialize() {
        view = orderPlacedView
        orderPlacedView.configure(isSuccess)
        orderPlacedView.okayButton.addTarget(
            self,
            action: #selector(okayButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    func okayButtonTapped() {
        dismiss(animated: true)
        guard let targetViewController = navController?.viewControllers.first else { return }
        navController?.popToViewController(targetViewController, animated: true)
        
    }
}
