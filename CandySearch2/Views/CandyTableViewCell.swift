//
//  TableViewCell.swift
//  CandySearch2
//
//  Created by Yehia Samak on 11/30/19.
//  Copyright © 2019 Yehia Samak. All rights reserved.
//

import UIKit

class CandyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func setValue(candy : Candy){
        nameLabel.text = candy.name;
        categoryLabel.text = candy.category;
    }

}

