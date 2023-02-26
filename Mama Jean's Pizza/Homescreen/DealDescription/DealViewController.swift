//
//  dealViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 24.02.2023.
//

import UIKit

class DealViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dealNameLabel: UILabel!
    @IBOutlet weak var dealDescriptionLabel: UILabel!
    @IBOutlet weak var orderNowButton: UIButton!
    
    var image: UIImage?
    var dealName = ""
    var dealDescription = ""
    var isOrderNowTapped = false
    
    var homePageDelegate: HomePageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // VIEW
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        
        dealNameLabel.text = dealName
        dealNameLabel.textColor = .systemGray
        dealNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        dealNameLabel.numberOfLines = 2
        
        dealDescriptionLabel.text = dealDescription
        dealDescriptionLabel.textColor = .systemGray2
        dealDescriptionLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        dealDescriptionLabel.numberOfLines = 2
        
        orderNowButton.layer.cornerRadius = 10
        orderNowButton.setTitleColor(.white, for: .normal)
        orderNowButton.setTitle("ORDER NOW!", for: .normal)
    }
    
    @IBAction func orderNowButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            self.homePageDelegate?.goToNewOrder()
        }
    }
}
