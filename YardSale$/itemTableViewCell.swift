//
//  itemTableViewCell.swift
//  YardSale$
//
//  Created by Josh Jaslow on 11/27/16.
//  Copyright © 2016 Josh Jaslow. All rights reserved.
//

import UIKit

class itemTableViewCell: UITableViewCell {
    // MARK: Properties
    //Create properties for every element that is displayed in a table cell
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    //Set specified cell as selected cell and show an animation as it opens a new page
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
