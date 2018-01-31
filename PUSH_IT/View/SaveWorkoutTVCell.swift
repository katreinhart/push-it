//
//  SaveWorkoutTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/30/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

protocol SaveWorkoutDelegate: class {
    func didPressSaveWorkoutButton(_ sender: SaveWorkoutTVCell)
}

class SaveWorkoutTVCell: UITableViewCell {
    
    weak var delegate: SaveWorkoutDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func AddExerciseBtnPressed(_ sender: SaveWorkoutTVCell) {
        delegate?.didPressSaveWorkoutButton(self)
    }
}

