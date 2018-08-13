//
//  itemTableViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 11/27/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit
import os.log

class itemTableViewController: UITableViewController{
    // MARK: - Properties
    var items: [Item] = [] //Array to store yardsale items
    @IBOutlet weak var donateButton: UIBarButtonItem!

    //MARK: - View Functions
    override func viewDidLoad() { //Loads view into table
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved items, otherwise load sample data.
        if let savedItems = loadItems() {
            items += savedItems
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let savedItems = loadItems() {
            items = savedItems
        }
        tableView.reloadData()
        
        if UserDefaults.standard.value(forKey: "yardsaleHasEnded") as? Bool == true {
            donateButton.isEnabled = false
            tableView.isUserInteractionEnabled = false
        }
        else {
            donateButton.isEnabled = true
            tableView.isUserInteractionEnabled = true
        }
    }
    
    // MARK: - Table setup and support functions
    override func numberOfSections(in tableView: UITableView) -> Int { //Table has 1 column
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //Creates table
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //Creates each cell in table with matching item from array
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "itemTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! itemTableViewCell
        // Fetches the appropriate meal for the data source layout.
        let item = items[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.categoryLabel.text = item.category
        cell.photoView.image = item.photo
        cell.ratingControl.rating = item.rating

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            saveItems()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //MARK: - Navigation
    @IBAction func unwindToItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DonationViewController, let item = sourceViewController.item {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing item.
                items[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                sortbyName()
                tableView.reloadData()
            }
            
            else {
                // Add a new item.
                let newIndexPath = IndexPath(row: items.count, section: 0)
                items.append(item)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                sortbyName()
                tableView.reloadData()
            }
            
            // Save the items.
            saveItems()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
            
            case "donateItem":
                os_log("Adding a new item.", log: OSLog.default, type: .debug)
        
            case "ShowDetail":
                guard let donationViewController = segue.destination as? DonationViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedItemCell = sender as? itemTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedItem = items[indexPath.row]
                donationViewController.item = selectedItem
            
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: - Data Manipulation Functions
    private func sortbyName() {
        items.sort{
            $0.name < $1.name
        }
    }
    
    private func saveItems() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(items, toFile: Item.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Items successfully saved.", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save items...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadItems() -> [Item]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Item.ArchiveURL.path) as? [Item]
    }
}
