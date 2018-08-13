//
//  OnboardingViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 2/12/17.
//  Copyright © 2017 Josh Jaslow. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var goalSet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalSet.delegate = self
    }
    
    // MARK: Text Field Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if goalSet.text != "" {
            UserDefaults.standard.set(Double(goalSet.text!), forKey: "goal")
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    @IBAction func getStarted(_ sender: UIButton) {
        performSegue(withIdentifier: "Get Started", sender: self)
    }
}
