//
//  ViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 11/16/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit

class ForSaleViewController: UIViewController {
    var buttonName = ""
    var buttonImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func Pickles(_ sender: AnyObject) {
        print("Pickles")
        buttonName = "Pickles"
        buttonImage = #imageLiteral(resourceName: "Pickles")
        
        
    }
    @IBAction func golfClubs(_ sender: AnyObject) {
        print("Golf Clubs")
        buttonName = "Golf Clubs"
        buttonImage = #imageLiteral(resourceName: "goldClubs")
    }

    @IBAction func PS2(_ sender: AnyObject) {
        print("Play Station 2")
        buttonName = "Play Station 2"
        buttonImage = #imageLiteral(resourceName: "PS2")
    }
    @IBAction func oldChair(_ sender: AnyObject) {
        print("Old Chair")
        buttonName = "Old Chair"
        buttonImage = #imageLiteral(resourceName: "Chair")
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get a reference to the second view controller
        let IDViewController = segue.destination as! ItemDataViewController
        
        // set a variable in the second view controller with the String to pass
        IDViewController.receivedString = buttonName
        IDViewController.receivedImage = buttonImage
    }

}
