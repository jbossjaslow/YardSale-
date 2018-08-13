//
//  Data.swift
//  YardSale$
//
//  Created by Josh Jaslow on 1/29/17.
//  Copyright © 2017 Josh Jaslow. All rights reserved.
//

import UIKit
import os.log

class Data: NSObject, NSCoding {
    
    // MARK: Properties
    var profit : Double
    var itemsSold: Double
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tempArr")
    
    //MARK: Types
    struct PropertyKey {
        static let profit = "profit"
        static let itemsSold = "itemsSold"
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(profit, forKey: PropertyKey.profit)
        aCoder.encode(itemsSold, forKey: PropertyKey.itemsSold)
    }
    
    // MARK: Initialization
    init(profit: Double, itemsSold: Double) {
        self.profit = profit
        self.itemsSold = itemsSold
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let profit = aDecoder.decodeDouble(forKey: PropertyKey.profit)
        let itemsSold = aDecoder.decodeDouble(forKey: PropertyKey.itemsSold)
        
        // Must call designated initializer.
        self.init(profit: profit, itemsSold: itemsSold)
    }
}
