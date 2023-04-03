import UIKit

class IntroPageController: UIPageViewController {
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let contentVC = showViewControllerAtIndex(0) {
            setViewControllers([contentVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private properties
    private let introPageModel = IntroPageModel()
}

// MARK: - Private methods
private extension IntroPageController {
    func showViewControllerAtIndex(_ index: Int) -> IntroController? {
        guard index >= 0 else { return nil }
        guard index < introPageModel.introHeaderArray.count else { return nil }
        let introductionTipsVC = IntroController()

        if index == 3 {
            introductionTipsVC.isFinalPage = true
        } else {
            introductionTipsVC.isFinalPage = false
        }
        introductionTipsVC.headerText = introPageModel.introHeaderArray[index]
        introductionTipsVC.bodyText = introPageModel.introBodyArray[index]
        introductionTipsVC.numberOfPages = introPageModel.introHeaderArray.count
        introductionTipsVC.currentPage = index

        return introductionTipsVC
    }
}

// MARK: - UIPageViewControllerDataSource protocol
extension IntroPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! IntroController).currentPage
        pageNumber -= 1
        return showViewControllerAtIndex(pageNumber)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! IntroController).currentPage
        pageNumber += 1
        return showViewControllerAtIndex(pageNumber)
    }
}
