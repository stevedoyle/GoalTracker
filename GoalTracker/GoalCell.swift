//
//  GoalCell.swift
//  GoalTracker
//
//  Created by Stephen Doyle on 15/01/2015.
//  Copyright (c) 2015 Stephen Doyle. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var percentCompleteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
