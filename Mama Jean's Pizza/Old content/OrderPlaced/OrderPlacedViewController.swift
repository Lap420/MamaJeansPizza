//
//  OrderPlacedViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 04.03.2023.
//

import UIKit

class OrderPlacedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = .white
        Basket.shared.clear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if let targetViewController = self.navigationController?.viewControllers[self.navigationController!.viewControllers.count - 6] {
                self.navigationController?.popToViewController(targetViewController, animated: true)
            }
        }
    }
}
