//
//  ChildRandomListTableViewCell.swift
//  RandomListTest
//
//  Created by Victor Stone on 2/1/17.
//  Copyright © 2017 Victor Stone. All rights reserved.
//

import CoreData
import UIKit

class ChildRandomListTableViewCell: UITableViewCell {
    @IBOutlet weak var itemNumberLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!

    func configure(item: RandomListItem) {
        itemNumberLabel.text = "\(item.num)."
        itemNameLabel.text = item.name
    }

}
