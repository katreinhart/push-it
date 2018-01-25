//
//  HistoryItemTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/25/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class HistoryItemTVCell: UITableViewCell {
    
    @IBOutlet weak var workoutDateLbl: UILabel!
    
    @IBOutlet weak var ex1NameLbl: UILabel!
    @IBOutlet weak var ex2NameLbl: UILabel!
    @IBOutlet weak var ex3NameLbl: UILabel!
    
    @IBOutlet weak var ex1WtLbl: UILabel!
    @IBOutlet weak var ex2WtLbl: UILabel!
    @IBOutlet weak var ex3WtLbl: UILabel!
    
    @IBOutlet weak var ex1RepsLbl: UILabel!
    @IBOutlet weak var ex2RepsLbl: UILabel!
    @IBOutlet weak var ex3RepsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
