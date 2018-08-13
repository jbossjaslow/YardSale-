//
//  Onboarding_4ViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 2/20/17.
//  Copyright © 2017 Josh Jaslow. All rights reserved.
//

import UIKit

class Onboarding_4ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func information(_ sender: UIButton) {
        let alert = UIAlertController(title: "Manage Page", message: "This page records the number of items sold, the total profit, the goal amount, and the progress towards the goal. Press Settings to access the settings page. When you are finished with your sale, press End Yard Sale.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "I Understand", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
