//
//  Item.swift
//  YardSale$
//
//  Created by Josh Jaslow on 11/24/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit
import os.log

class Item: NSObject, NSCoding {
    
    // MARK: Properties
    var name : String
    var price: Double
    let category: String //Category
    var photo: UIImage?
    var rating: Int
    var comment: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("items")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let price = "price"
        static let category = "category"
        static let photo = "photo"
        static let rating = "rating"
        static let comment = "comment"
    }
    
    // MARK: Initialization
    init(name: String, price: Double, category: String, photo: UIImage?, rating: Int, comment: String) {
        self.name = name
        self.price = price
        self.category = category
        self.photo = photo
        self.rating = rating
        self.comment = comment
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(price, forKey: PropertyKey.price)
        aCoder.encode(category, forKey: PropertyKey.category)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(comment, forKey: PropertyKey.comment)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Item object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let category = aDecoder.decodeObject(forKey: PropertyKey.category) as? String else {
            os_log("Unable to decode the category for a Item object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let comment = aDecoder.decodeObject(forKey: PropertyKey.comment) as? String else {
            os_log("Unable to decode the comment for a Item object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Item, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let price = aDecoder.decodeDouble(forKey: PropertyKey.price)
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(name: name, price: price, category: category, photo: photo, rating: rating, comment: comment)
    }
}
