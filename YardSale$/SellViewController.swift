//
//  SellViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 12/3/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit
import os.log

class SellViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var picker: UIPickerView! //create item selection reel
    @IBOutlet weak var sellButton: UIBarButtonItem! //Create item in navigation bar
    @IBOutlet weak var suggestedPrice: UILabel!
    @IBOutlet weak var actualPrice: UITextField!
    
    var pickerData: [Item] = [] //Create an array to hold all the items in the selection reel
    var sellPrice: Int = 0
    var tempItem: Item?
    var chosenItem: Item? = nil
    
    //MARK: - View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        actualPrice.delegate = self
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickerData = []
        // Input data into the Array:
        pickerData = loadItems()!
        
        //First item in picker is automatically selected when page appears
        if pickerData.isEmpty == false {
            let firstItem = pickerData[0]
            navigationItem.title = ("Sell \(firstItem.name)")
            suggestedPrice.text = String("Suggested Sell Price: $ \(firstItem.price)")
            chosenItem = firstItem
        }
        else {
            navigationItem.title = "No items to sell"
            sellButton.isEnabled = false
        }
    }
    
    //MARK: - Button functions
    @IBAction func cancel(sender: UIBarButtonItem) { //Return to table screen is cancel button is pressed
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Text Field Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState(textField: actualPrice)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        sellButton.isEnabled = false
    }
    
    private func updateSaveButtonState(textField: UITextField) {
        // Disable the Save button if the text field is empty.
        sellButton.isEnabled = !(textField.text?.isEmpty)!
    }
    
    //MARK: - Picker Settings
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data for each row of the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerData.isEmpty == false {
            return pickerData[row].name
        }
        else {
            return nil
        }
    }
    
    // Do something with whichever row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        if pickerData.isEmpty == false {
            let item = pickerData[row]
            navigationItem.title = ("Sell \(item.name)")
            suggestedPrice.text = String("Suggested Sell Price: $ \(item.price)")
            chosenItem = item
        }
    }
    
    //MARK: - Data saving and retrieval
    private func loadItems() -> [Item]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as? [Item]
    }
    
    private func saveItems() {
        NSKeyedArchiver.archiveRootObject(pickerData, toFile: Item.ArchiveURL.path)
    }
    
    //Mark: - Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === sellButton else {
            os_log("The sell button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        pickerData = pickerData.filter({$0 != chosenItem})
        saveItems()
        
        chosenItem?.price = Double(actualPrice.text!)!
        tempItem = chosenItem
    }
}
