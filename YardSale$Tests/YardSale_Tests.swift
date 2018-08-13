//
//  YardSale_Tests.swift
//  YardSale$Tests
//
//  Created by Josh Jaslow on 11/16/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import XCTest
@testable import YardSale_

class YardSale_Tests: XCTestCase {
    
    // MARK: YardSale$ Tests
    // Confirm that the Item initializer returns a Item object when passed valid parameters.
    func testItemInitializationSucceeds() {
        //Zero rating
        let zeroRatingItem = Item.init(name: "Fun", price: 10000, category: "Priceless Artifacts", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingItem)
        
        //Five rating
        let fiveRatingItem = Item.init(name: "Joy", price: 10000, category: "Priceless Artifacts", photo: nil, rating: 5)
        XCTAssertNotNil(fiveRatingItem)
    }
    
    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
    func testMealInitializationFails() {
        //Negative Rating
        let negOneRatingItem = Item.init(name: "Sadness", price: 10000, category: "Priceless Artifacts", photo: nil, rating: -1)
        XCTAssertNil(negOneRatingItem)
        
        //Oversized Rating
        let sixRatingItem = Item.init(name: "Grief", price: 10000, category: "Priceless Artifacts", photo: nil, rating: 6)
        XCTAssertNil(sixRatingItem)
        
        //Will Fail
        let sevenRatingItem = Item.init(name: "Curiosity", price: 10000, category: "Priceless Artifacts", photo: nil, rating: 7)
        XCTAssertNil(sevenRatingItem)
    }

}
