//
//  SettingsViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 1/30/17.
//  Copyright © 2017 Josh Jaslow. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK: - Properties
    var receivedGoal: Double = 0
    
    //MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
    }
    
    @IBAction func changeGoalAmount(_ sender: UIButton) {
        let alert = UIAlertController(title: "Change Goal", message: "Choose a new goal for your sale", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField{ (tempTextField: UITextField) in
            tempTextField.placeholder = "Change goal from $\(String(self.receivedGoal))?"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) in
            
            if let textField = alert.textFields?.first {
                if textField.text == "" {
                    print("You have to enter something first")
                }
                else{
                    UserDefaults.standard.set(Double(textField.text!), forKey: "goal")
                }
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
