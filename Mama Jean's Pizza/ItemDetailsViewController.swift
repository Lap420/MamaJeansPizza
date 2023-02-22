//
//  ItemDetailsViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 16.02.2023.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var image: UIImage?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        nameLabel.text = name
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
        guard image != nil else { return }
        
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("Successful")
            }
        }
        
        present(shareController, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
