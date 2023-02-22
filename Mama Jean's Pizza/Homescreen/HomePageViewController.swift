//
//  ViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 12.02.2023.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var topGreenView: UIView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var mamaJeansLabel: UILabel!
    @IBOutlet weak var orderNowButton: UIButton!
    @IBOutlet weak var repeatOrderButton: UIButton!
    @IBOutlet weak var dealsCollectionView: UICollectionView!
    @IBOutlet weak var rewardsCollectionView: UICollectionView!
    @IBOutlet weak var pointsCollectionView: UICollectionView!
    
    private var deals: [Deal] = []
    private var rewards: [Reward] = []
    private var points: [Point] = []
    

    //let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        
        topGreenView.backgroundColor = UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
        
        mamaJeansLabel.text = "MAMA JEANS"
        mamaJeansLabel.textColor = .white
        mamaJeansLabel.font = .systemFont(ofSize: 24, weight: .black)
        
        pointsLabel.text = "🍕0"
        pointsLabel.textColor = .white
        pointsLabel.font = .systemFont(ofSize: 14)
        pointsLabel.textAlignment = .right
        
        orderNowButton.layer.cornerRadius = 10
        orderNowButton.clipsToBounds = true
        orderNowButton.contentMode = .scaleAspectFill
        orderNowButton.setImage(UIImage(named: "OrderNow"), for: .normal)
        
        repeatOrderButton.layer.cornerRadius = 10
        repeatOrderButton.clipsToBounds = true
        repeatOrderButton.contentMode = .scaleAspectFill
        repeatOrderButton.setImage(UIImage(named: "RepeatOrder"), for: .normal)
        
        dealsCollectionView.showsHorizontalScrollIndicator = false
        dealsCollectionView.delegate = self
        dealsCollectionView.dataSource = self
        
        FirebaseManager.shared.getDeals(collection: "Deals") { deals in
            guard deals.count > 0 else { return }
            
            self.deals = deals
            DispatchQueue.main.async {
                self.dealsCollectionView.reloadData()
            }
        }
        
        rewardsCollectionView.showsHorizontalScrollIndicator = false
        rewardsCollectionView.delegate = self
        rewardsCollectionView.dataSource = self
        
        FirebaseManager.shared.getImage(path: "Rewards", picName: "Earn Mama Points") { image1 in
            let reward1 = Reward(image: image1)
            self.rewards.append(reward1)
            FirebaseManager.shared.getImage(path: "Rewards", picName: "Invite friends") { image2 in
                let reward2 = Reward(image: image2)
                self.rewards.append(reward2)
                
                DispatchQueue.main.async {
                    self.rewardsCollectionView.reloadData()
                }
            }
        }
        
        
        // TODO: Констрейнты через код
        
        // Show the Introduction only once for a user
        //let userDefaults = UserDefaults.standard
        //let presentationWasViewed = userDefaults.bool(forKey: "PresentationWasViewed")
        //let presentationWasSkipped = userDefaults.bool(forKey: "PresentationWasSkipped")
//        let presentationWasViewed = false
//        if presentationWasViewed == false {
//            startIntroductionTips()
//        }
    }

    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destinationVC = segue.destination as? ChooseAStoreTableViewController else { return }
//
//
//    }
    
    // MARK: - Buttons
    
    @IBAction func orderNowButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "FromHomePageToStoreChoosing", sender: nil)
    }
    
    @IBAction func repeatOrderButtonTapped(_ sender: UIButton) {
        
        showAlert(title: "Oops...", message: "This feature is coming soon. Will keep you posted.")
    }
    
    func startIntroductionTips() {
        
        if let introductionTipsPageVC = storyboard?.instantiateViewController(withIdentifier: "introductionTipsPageVC") as? IntroductionTipsPageViewController {
            
            present(introductionTipsPageVC, animated: true)
        }
    }
}

// MARK: - Alert extension

extension HomePageViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
//        alert.addAction(cancelAction)
//        alert.addAction(deleteAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


// MARK: - Collections DataSource

extension HomePageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == dealsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Deal", for: indexPath)
                as! DealCell
            
            cell.name = deals[indexPath.row].name
            cell.dealDescription = deals[indexPath.row].dealDescription
            cell.imageView.image = deals[indexPath.row].image
            return cell
        }
        
        if collectionView == rewardsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Reward", for: indexPath)
                as! RewardsCell
        
            cell.imageView.image = rewards[indexPath.row].image
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Point", for: indexPath)
            as! PointsCell
        
        cell.imageView.image = points[indexPath.row].image
        return cell
    }
}
