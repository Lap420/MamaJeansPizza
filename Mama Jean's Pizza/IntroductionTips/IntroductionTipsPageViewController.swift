//
//  NewUserPageViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 12.02.2023.
//

import UIKit

class IntroductionTipsPageViewController: UIPageViewController {

    var introductionTextArray = ["Welcome to\nMama Jean`s Pizza!",
                                 "Repeat your order",
                                 "Delicious pizza!",
                                 "Enjoy your meal!"]
    var introductionEmojiArray = ["Please read the introduction tips and receive 100 bonuses to your Mama`s account",
                                  "You can repeat any your previous order. For this please find \"Repeat order\" button on the main page",
                                  "We use only the highest quality ingredients in our pizzas, which are made especially for you.",
                                  "🍕🥤🍟"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let contentVC = showViewControllerAtIndex(0) {
            setViewControllers([contentVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> IntroductionTipsViewController? {
            
        guard index >= 0 else { return nil }
        guard index < introductionTextArray.count else { return nil }
        
        guard let introductionTipsVC = storyboard?.instantiateViewController(withIdentifier: "introductionTipsVC") as? IntroductionTipsViewController else { return nil }
            
        if index == 3 {
            introductionTipsVC.isFinalPage = true
        } else {
            introductionTipsVC.isFinalPage = false
        }
        introductionTipsVC.introText = introductionTextArray[index]
        introductionTipsVC.introEmoji = introductionEmojiArray[index]
        introductionTipsVC.numberOfPages = introductionTextArray.count
        introductionTipsVC.currentPage = index
            
        return introductionTipsVC
    }
}

extension IntroductionTipsPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! IntroductionTipsViewController).currentPage
        pageNumber -= 1
            
        return showViewControllerAtIndex(pageNumber)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var pageNumber = (viewController as! IntroductionTipsViewController).currentPage
        pageNumber += 1
            
        return showViewControllerAtIndex(pageNumber)
    }
}
