//
//  ViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 12.02.2023.
//

// TODO: Constraints by code
// TODO: Do a segue from Deals Cell to the new page with Deals description
// TODO: Develop "Repeat order" based on local DB with previous orders

import UIKit

class HomePageViewController: UIViewController, IntroductionPointsDelegate {
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
    
    private var deals: [HomepageData] = []
    private var rewards: [HomepageData] = []
    private var points: [HomepageData] = []

    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.set(0, forKey: "Points")
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
        
        func initCollectionDelegateAndSource(collectionView: UICollectionView!) {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
        
        initCollectionDelegateAndSource(collectionView: dealsCollectionView)
        initCollectionDelegateAndSource(collectionView: rewardsCollectionView)
        initCollectionDelegateAndSource(collectionView: pointsCollectionView)
        
        FirebaseManager.shared.getHomepageData(collection: "Deals") { deals in
            guard deals.count > 0 else { return }

            self.deals = deals
            DispatchQueue.main.async {
                self.dealsCollectionView.reloadData()
            }
        }
        FirebaseManager.shared.getHomepageData(collection: "Rewards") { rewards in
            guard rewards.count > 0 else { return }

            self.rewards = rewards
            DispatchQueue.main.async {
                self.rewardsCollectionView.reloadData()
            }
        }
        FirebaseManager.shared.getHomepageData(collection: "Points") { points in
            guard points.count > 0 else { return }

            self.points = points
            DispatchQueue.main.async {
                self.pointsCollectionView.reloadData()
            }
        }
        
        //Show the Introduction only once for a user
        //let presentationWasSkipped = userDefaults.bool(forKey: "PresentationWasSkipped")
        var presentationWasViewed = userDefaults.bool(forKey: "PresentationWasViewed")
        presentationWasViewed = false
        if presentationWasViewed == false {
            userDefaults.set(0, forKey: "Points")
            startIntroductionTips()
        }
    }

    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destinationVC = segue.destination as? ChooseAStoreTableViewController else { return }
//    }
    
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
            
            introductionTipsPageVC.firstTipsDelegate = self
            present(introductionTipsPageVC, animated: true)
        }
    }
    
    func updatePointsLabel() {
        pointsBalanceLabel.text = "🍕" + String(userDefaults.integer(forKey: "Points"))
    }
}

// MARK: - Collections DataSource

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Deal", for: indexPath)
                as! DealCell
            
            cell.name = deals[indexPath.row].name
            cell.dealDescription = deals[indexPath.row].dealDescription
            cell.imageView.image = deals[indexPath.row].image
            cell.imageView.contentMode = .scaleAspectFit
            return cell
        }
        
        if collectionView == rewardsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Reward", for: indexPath)
                as! RewardsCell
        
            cell.imageView.image = rewards[indexPath.row].image
            cell.imageView.contentMode = .scaleAspectFit
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Point", for: indexPath)
            as! PointsCell
        
        cell.imageView.image = points[indexPath.row].image
        cell.imageView.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case dealsCollectionView:
            return
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

protocol IntroductionPointsDelegate {
    func updatePointsLabel()
}
