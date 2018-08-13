//
//  MasterViewController.swift
//  YardSale$
//
//  Created by Josh Jaslow on 11/24/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
            Item(name:"Old Chair", price: 30, category: .Furniture),
            Item(name:"Pickles", price: 10, category: .Kids),
        ]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}