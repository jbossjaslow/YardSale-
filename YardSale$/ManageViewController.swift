//
//  ManageViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 12/3/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit
import os.log

class ManageViewController: UIViewController{
    //MARK: - Properties
    //Aspects of the manager class
    var currentAmt: Double = 0 {
        didSet {
            updateProgressBar()
            totalSales.text = "\(currentAmt)"
        }
    }
    var itemsSold: Double = 0 {
        didSet {
            itemsSoldLabel.text = "\(Int(itemsSold))"
        }
    }
    var goal: Double = 0 {
        didSet {
            updateProgressBar()
            goalAmt.text = ("$\(goal)")
        }
    }
    var tempArr: [Double] = []
    
    @IBOutlet weak var totalSales: UILabel!
    @IBOutlet weak var itemsSoldLabel: UILabel!
    @IBOutlet weak var goalAmt: UILabel!
    @IBOutlet weak var goalProgress: UIProgressView!
    @IBOutlet weak var newYardSale: UIButton!
    @IBOutlet weak var sellButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    //MARK: - Button Functions
    @IBAction func endYardSale(_ sender: UIButton) {
        let alert = UIAlertController(title: "End Yard Sale", message: "Are you sure you want to do this? You will no longer be able to add or sell items in the sale", preferredStyle: UIAlertControllerStyle.alert)
            
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action: UIAlertAction) in
            UserDefaults.standard.set(true, forKey: "yardsaleHasEnded")
            self.newYardSale.isHidden = false
            self.settingsButton.isEnabled = false
            self.sellButton.isEnabled = false
        }))
            
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func newYardSale(_ sender: UIButton) {
        let alert = UIAlertController(title: "Create a new yard sale", message: "Delete all data from the yard sale and start over? Warning: This action is permaneant", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField{ (tempTextField: UITextField) in
            tempTextField.placeholder = "Pick a Goal"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
            var newGoal: Double = 0
            
            if let textField = alert.textFields?.first {
                if textField.text == "" {
                    //Do nothing
                }
                else{
                    newGoal = Double(textField.text!)!
                }
            }
            
            UserDefaults.standard.set(newGoal, forKey: "goal")
            self.tempArr = [0,0]
            self.saveData()
            self.itemsSold = 0
            self.currentAmt = 0
            self.goal = newGoal
            self.settingsButton.isEnabled = true
            self.sellButton.isEnabled = true
            NSKeyedArchiver.archiveRootObject([], toFile: Item.ArchiveURL.path) //clears out all the items
            self.newYardSale.isHidden = true //Hides button again
            UserDefaults.standard.set(false, forKey: "yardsaleHasEnded")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - View and update functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedArr = loadData(){
            currentAmt = loadedArr[0]
            itemsSold = loadedArr[1]
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.value(forKey: "yardsaleHasEnded") as? Bool == true {
            self.newYardSale.isHidden = false
        }
        else {
            self.newYardSale.isHidden = true
        }
        
        goal = UserDefaults.standard.value(forKey: "goal") as! Double
    }
    
    //Change the progress bar to reflect progress towards the goal each time an item is sold
    private func updateProgressBar(){
        goalProgress.setProgress(Float(currentAmt/goal), animated: true)
    }
    
    //MARK: - Data Saving and Retrieval
    private func loadData() -> [Double]?{
       return NSKeyedUnarchiver.unarchiveObject(withFile: Data.ArchiveURL.path) as? [Double]
    }
    
    private func saveData() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tempArr, toFile: Data.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Data successfully saved.", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save data...", log: OSLog.default, type: .error)
        }
    }
    
    @IBAction func resetUserDefaultsGoal(_ sender: UIButton) {
        UserDefaults.standard.set(nil, forKey: "goal")
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Settings Segue" {
            let settingsVC = segue.destination as! SettingsViewController
            settingsVC.receivedGoal = goal
        }
    }
    
    @IBAction func unwindToItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? SellViewController, let item = sourceViewController.tempItem {
            currentAmt += item.price
            itemsSold += 1
            
            tempArr = [currentAmt, itemsSold]
            saveData()
        }
    }
}
