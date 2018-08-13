//
//  Onboarding_5ViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 2/17/17.
//  Copyright © 2017 Josh Jaslow. All rights reserved.
//

import UIKit

class Onboarding_5ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func information(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sell Items Page.", message: "Drag down on the list to select an item. The title at the top of the page will change to reflect which item has been picked. Choose an amount to sell the item for; the suggested price is listed above. Press Sell to sell the item and Cancel to return to the managa page.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "I Understand", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
