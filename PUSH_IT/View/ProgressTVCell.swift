//
//  ProgressTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/26/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit
import Charts

protocol ProgressChartDelegate {
    // render chart function
    func renderChart()
}

class ProgressTVCell: UITableViewCell {
 
    // outlets
    @IBOutlet weak var exerciseNameLbl: UILabel!
    @IBOutlet weak var chartView: UIView!
    
    // variables
    var chartData = [Int]()
    
    
    // lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
