//
//  Onboarding_3ViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 2/20/17.
//  Copyright © 2017 Josh Jaslow. All rights reserved.
//

import UIKit

class Onboarding_3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func information(_ sender: UIButton) {
        let alert = UIAlertController(title: "Donation Page", message: "After filling in each of the fields, tap Done to add the item to the list. Press Cancel to return back to the item list.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "I Understand", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
