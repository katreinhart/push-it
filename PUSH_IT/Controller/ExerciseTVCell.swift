//
//  ExerciseTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class ExerciseTVCell: UITableViewCell {
    
    var exerciseName: String = "" 
    var targetWeight: Int = 0
    var reps: Int = 0
    var sets: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
