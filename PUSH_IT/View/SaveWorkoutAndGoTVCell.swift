//
//  SaveWorkoutAndGoTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

protocol SaveAndGoDelegate: class {
    func didPressSaveAndGoButton(_ sender: SaveWorkoutAndGoTVCell)
}

class SaveWorkoutAndGoTVCell: UITableViewCell {
    
    weak var delegate: SaveAndGoDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func AddExerciseBtnPressed(_ sender: SaveWorkoutAndGoTVCell) {
        delegate?.didPressSaveAndGoButton(self)
    }
}
