//
//  Onboarding_2ViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 2/17/17.
//  Copyright © 2017 Josh Jaslow. All rights reserved.
//

import UIKit

class Onboarding_2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func information(_ sender: UIButton) {
        let alert = UIAlertController(title: "Item List", message: "Tap the Donate button to add items to the sale. Touch an item to edit it. Use the Edit button to remove items from the table.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "I Understand", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
