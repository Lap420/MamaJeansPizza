import UIKit

class IntroController: UIViewController {
    // MARK: - Public properties
    var headerText = ""
    var bodyText = ""
    var numberOfPages = 0
    var currentPage = 0
    var isFinalPage = false

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let introFinished = UserDefaultsManager.loadIntroFinished()
        guard !introFinished else { return }
        UserDefaultsManager.saveIntroSkipped()
    }
    
    // MARK: - Private properties
    private lazy var introView = IntroView()
}

// MARK: - Private methods
private extension IntroController {
    func initialize() {
        view = introView
        initButtonTargets()
        introView.headerLabel.text = headerText
        introView.bodyLabel.text = bodyText
        introView.pageControl.numberOfPages = numberOfPages
        introView.pageControl.currentPage = currentPage

        if isFinalPage == true {
            introView.finishIntroButton.isHidden = false
            introView.skipIntroButton.isHidden = true
            introView.bodyLabel.font = .systemFont(ofSize: 69, weight: .medium)
        } else {
            introView.finishIntroButton.isHidden = true
            introView.skipIntroButton.isHidden = false
        }
    }
    
    func initButtonTargets() {
        introView.skipIntroButton.addTarget(
            self,
            action: #selector(skipIntroButtonTapped),
            for: .touchUpInside
        )
        introView.finishIntroButton.addTarget(
            self,
            action: #selector(finishIntroButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    func skipIntroButtonTapped() {
        dismiss(animated: true)
    }

    @objc
    func finishIntroButtonTapped() {
        UserDefaultsManager.saveIntroFinished()
        BalanceObserver.shared.updateBalance(100)
        dismiss(animated: true)
    }
}
