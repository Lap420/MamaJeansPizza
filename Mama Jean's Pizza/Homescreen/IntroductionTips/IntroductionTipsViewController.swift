//
//  NewUserViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 12.02.2023.
//

import UIKit

class IntroductionTipsViewController: UIViewController {
    @IBOutlet weak var skipIntroductionTipsButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var closeIntroductionTipsButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!

    var introText = "1"
    var introEmoji = ""
    var numberOfPages = 0
    var currentPage = 0
    var isFinalPage = false
    
    let userDefaults = UserDefaults.standard
    
    var homePageDelegate: HomePageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Прописать свойства всех элементов в коде (шрифт, размер шр, цвета и т.д.)
        // TODO: Констрейнты через код
        
        skipIntroductionTipsButton.setTitle("Skip", for: .normal)
        
        textLabel.text = introText
        textLabel.font = .systemFont(ofSize: 24, weight: .bold)
        textLabel.numberOfLines = 2
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
        
        emojiLabel.text = introEmoji
        emojiLabel.font = .systemFont(ofSize: 16, weight: .medium)
        emojiLabel.numberOfLines = 4
        emojiLabel.textAlignment = .center
        emojiLabel.textColor = UIColor(hue: 116/359, saturation: 0, brightness: 0.47, alpha: 1)
        
        closeIntroductionTipsButton.setTitle("Get my 100 points and\nlet's get started!", for: .normal)
        
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage

        if isFinalPage == true {
            closeIntroductionTipsButton.isHidden = false
            skipIntroductionTipsButton.isHidden = true
            emojiLabel.font = .systemFont(ofSize: 46, weight: .medium)
        } else {
            closeIntroductionTipsButton.isHidden = true
            skipIntroductionTipsButton.isHidden = false
        }
        
    }
    
    @IBAction func skipIntroductionTipsButtonTapped(_ sender: UIButton) {
        userDefaults.set(true, forKey: "PresentationWasSkipped")
        dismiss(animated: true) {
            print("User skipped the intro and lost 100 points")
        }
    }
    
    @IBAction func closeIntroductionTipsButtonTapped(_ sender: UIButton) {
        userDefaults.set(true, forKey: "PresentationWasViewed")
        userDefaults.set(100, forKey: "Points")
        homePageDelegate?.updatePointsLabel()
        dismiss(animated: true) {
            print("100 points added!")
        }
    }
}
