//
//  ItemDataViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 11/18/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit

class ItemDataViewController: UIViewController {
    @IBOutlet weak var nameOfItem: UILabel!
    @IBOutlet weak var itemPic: UIImageView!
    var receivedString = ""
    var receivedImage: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Used the text from the First View Controller to set the label
        nameOfItem.text = receivedString
        itemPic.image = receivedImage


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
