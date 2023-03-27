//
//  ViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 12.02.2023.
//

// TODO: Constraints by code
// TODO: Develop "Repeat order" based on local DB with previous orders

import SnapKit
import UIKit

class HomePageViewController2: UIViewController, HomePageDelegate {
    @IBOutlet weak var mamaJeansLabel: UILabel!
    @IBOutlet weak var pointsBalanceLabel: UILabel!
    @IBOutlet weak var topButtonsStackView: UIStackView!
    @IBOutlet weak var orderNowButton: UIButton!
    @IBOutlet weak var repeatOrderButton: UIButton!
    @IBOutlet weak var dealsLabel: UILabel!
    @IBOutlet weak var dealsCollectionView: UICollectionView!
    @IBOutlet weak var rewardsLabel: UILabel!
    @IBOutlet weak var rewardsCollectionView: UICollectionView!
    @IBOutlet weak var useYourPointsLabel: UILabel!
    @IBOutlet weak var pointsCollectionView: UICollectionView!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var bottomButtonsStackView: UIStackView!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    
    private var deals: [HomePageData] = []
    private var rewards: [HomePageData] = []
    private var points: [HomePageData] = []
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
    // MARK: TEMPORARY
    //    userDefaults.set(0, forKey: "Points")
        
    // MARK: VIEW
        
        let interitemSpacing: CGFloat = 10
        let sectionSpacing: CGFloat = 20
        
        self.navigationController?.navigationBar.tintColor = .white
        
        view.backgroundColor = .white
        view.contentMode = .scaleToFill
        
        let topView = TopView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        topView.center = view.center
        topView.backgroundColor = .clear
        view.addSubview(topView)
        view.sendSubviewToBack(topView)
        
        mamaJeansLabel.text = "MAMA JEANS"
        mamaJeansLabel.textColor = .white
        mamaJeansLabel.font = .systemFont(ofSize: 24, weight: .black)
        
        pointsBalanceLabel.text = "🍕" + String(userDefaults.integer(forKey: "Points"))
        pointsBalanceLabel.textColor = .white
        pointsBalanceLabel.font = .systemFont(ofSize: 14)
        pointsBalanceLabel.textAlignment = .right
        
        topButtonsStackView.distribution = .fillEqually
        topButtonsStackView.spacing = 30
        
        dealsCollectionView.backgroundColor = .clear
        rewardsCollectionView.backgroundColor = .clear
        pointsCollectionView.backgroundColor = .clear
        
        orderNowButton.layer.cornerRadius = 10
        orderNowButton.clipsToBounds = true
        orderNowButton.contentMode = .scaleAspectFill
        orderNowButton.setImage(UIImage(named: "OrderNow"), for: .normal)
        
        repeatOrderButton.layer.cornerRadius = 10
        repeatOrderButton.clipsToBounds = true
        repeatOrderButton.contentMode = .scaleAspectFill
        repeatOrderButton.setImage(UIImage(named: "RepeatOrder"), for: .normal)
        
        dealsLabel.text = "DEALS"
        dealsLabel.textColor = .black
        dealsLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        dealsCollectionView.showsHorizontalScrollIndicator = false
        if let dealsLayout = dealsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            dealsLayout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
            dealsLayout.minimumInteritemSpacing = interitemSpacing
        }
  
        rewardsLabel.text = "MAMA REWARDS"
        rewardsLabel.textColor = .black
        rewardsLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        rewardsCollectionView.showsHorizontalScrollIndicator = false
        if let rewardsLayout = rewardsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            rewardsLayout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
            rewardsLayout.minimumInteritemSpacing = interitemSpacing
        }
        
        useYourPointsLabel.text = "USE YOUR MAMA POINTS"
        useYourPointsLabel.textColor = .black
        useYourPointsLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        pointsCollectionView.showsHorizontalScrollIndicator = false
        if let pointsLayout = pointsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            pointsLayout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
            pointsLayout.minimumInteritemSpacing = interitemSpacing
        }
        
        rateButton.layer.cornerRadius = 20
        rateButton.clipsToBounds = true
        rateButton.contentMode = .scaleAspectFill
        rateButton.setImage(UIImage(named: "RateOurApp"), for: .normal)
        
        bottomButtonsStackView.distribution = .fillEqually
        
        instagramButton.setTitle("   Instagram", for: .normal)
        instagramButton.setTitleColor(.white, for: .normal)
        instagramButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        
        facebookButton.setTitle("Facebook", for: .normal)
        facebookButton.setTitleColor(.white, for: .normal)
        facebookButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        
        linkedinButton.setTitle("LinkedIn   ", for: .normal)
        linkedinButton.setTitleColor(.white, for: .normal)
        linkedinButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        
    // MARK: CONTROLLER
        
        //initCollectionsData()
        DispatchQueue.global(qos: .utility).async { _ = MenuManager.shared  }
        
        //Show the Introduction only once for a user
        //let presentationWasSkipped = userDefaults.bool(forKey: "PresentationWasSkipped")
        let presentationWasViewed = userDefaults.bool(forKey: "PresentationWasViewed")
        //presentationWasViewed = false
        if presentationWasViewed == false {
            userDefaults.set(0, forKey: "Points")
            startIntroductionTips()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
    }
    
    // MARK: - Buttons
    
    @IBAction func orderNowButtonTapped(_ sender: UIButton) { goToNewOrder() }
    
    @IBAction func repeatOrderButtonTapped(_ sender: UIButton) {
        showAlert(title: "Oops...", message: "This feature is coming soon. Will keep you posted.")
    }
    
    @IBAction func rateButtonTapped(_ sender: UIButton) { openLapTelegram() }
    
    @IBAction func instagramButtonTapped(_ sender: UIButton) { openLapTelegram() }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) { openLapTelegram() }
    
    @IBAction func linkedinButtonTapped(_ sender: Any) { openLapTelegram() }
    
    func goToNewOrder() {
        performSegue(withIdentifier: "FromHomePageToStoreChoosing", sender: nil)
    }
    
    func openLapTelegram() {
        if let url = URL(string: "https://t.me/lap42") {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func startIntroductionTips() {
        if let introductionTipsPageVC = storyboard?.instantiateViewController(withIdentifier: "introductionTipsPageVC") as? IntroductionTipsPageViewController {
            
            introductionTipsPageVC.homePageDelegate = self
            present(introductionTipsPageVC, animated: true)
        }
    }
    
    func updatePointsLabel() {
        pointsBalanceLabel.text = "🍕" + String(userDefaults.integer(forKey: "Points"))
    }
    
    func initCollectionsDelegateAndSource() {
        dealsCollectionView.delegate = self
        dealsCollectionView.dataSource = self
        rewardsCollectionView.delegate = self
        rewardsCollectionView.dataSource = self
        pointsCollectionView.delegate = self
        pointsCollectionView.dataSource = self
    }
    
    func getHomePageData(collectionType: HomepageCollectionType, group: DispatchGroup) {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            FirebaseManager.shared.getHomepageData(collection: collectionType.rawValue) { [weak self] data in
                guard data.count > 0 else { group.leave(); return }
                switch collectionType {
                case .deals:
                    self?.deals = data
                case .rewards:
                    self?.rewards = data
                case .points:
                    self?.points = data
                }
                group.leave()
            }
        }
    }
    
    func initCollectionsData() {
        initCollectionsDelegateAndSource()
        
        let group = DispatchGroup()
        
        getHomePageData(collectionType: .deals, group: group)
        getHomePageData(collectionType: .rewards, group: group)
        getHomePageData(collectionType: .points, group: group)
        
        group.notify(queue: .main) {
            self.dealsCollectionView.reloadData()
            self.rewardsCollectionView.reloadData()
            self.pointsCollectionView.reloadData()
        }
    }
    
    func downloadMenu() { _ = MenuManager.shared }
}

// MARK: - Collections DataSource

extension HomePageViewController2: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case dealsCollectionView:
            return deals.count
        case rewardsCollectionView:
            return rewards.count
        case pointsCollectionView:
            return points.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == dealsCollectionView {
            //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Deal", for: indexPath) as! DealCell
            
            //cell.imageView.image = deals[indexPath.row].image
            //cell.imageView.contentMode = .scaleAspectFit
            //return cell
        }
        
        if collectionView == rewardsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Reward", for: indexPath)
                as! RewardsCell2
        
            cell.imageView.image = rewards[indexPath.row].imageData
            cell.imageView.contentMode = .scaleAspectFit
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Point", for: indexPath)
            as! PointsCell2
        
        cell.imageView.image = points[indexPath.row].imageData
        cell.imageView.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case dealsCollectionView:
            if let dealVC = storyboard?.instantiateViewController(withIdentifier: "dealVC") as? DealViewController {
                dealVC.homePageDelegate = self
                dealVC.dealName = deals[indexPath.row].name
                dealVC.dealDescription = deals[indexPath.row].description
                dealVC.image = deals[indexPath.row].imageData
                present(dealVC, animated: true)
            }
        case rewardsCollectionView:
            goToNewOrder()
        case pointsCollectionView:
            goToNewOrder()
        default:
            return
        }
    }
}

class TopView: UIView {
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/5))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY/4))
        path.close()
        UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1).setFill()
        path.fill()
    }
}

protocol HomePageDelegate2 {
    func updatePointsLabel()
    func goToNewOrder()
}
