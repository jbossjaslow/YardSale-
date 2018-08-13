//
//  Owner.swift
//  YardSale$
//
//  Created by Josh Jaslow on 11/27/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit
class Owner{
    // MARK: Properties
    //Aspects of the yardsale important to the owner
    var profit: Double
    var itemsSold: Int
    var itemsDonated: Int
    var goal: Double

    // MARK: Initialization
    //Initialize a new goal for the yardsale and reset all statistics
    init(goal: Double){
        profit = 0
        itemsSold = 0
        itemsDonated = 0
        self.goal = goal
    }
    
    // MARK: Methods
    //Getter and setter for various properties
    func changeProfit (dollars: Double){
        profit += dollars
    }
    
    func getProfit() -> Double{
        return profit
    }
    
    func setNewGoal(newGoalAmt: Double){
        goal = newGoalAmt
    }
}
