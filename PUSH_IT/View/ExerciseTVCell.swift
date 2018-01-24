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

    // Outlets
    
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var setsLbl: UILabel!
    @IBOutlet weak var repsLbl: UILabel!
    @IBOutlet weak var exerciseNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        exerciseNameLbl.text = exerciseName
        weightLbl.text = String(targetWeight)
        setsLbl.text = String(sets)
        repsLbl.text = String(reps)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
