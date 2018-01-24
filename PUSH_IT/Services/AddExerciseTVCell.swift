//
//  AddExerciseTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

protocol AddCellDelegate: class {
    func didPressButton(_ sender: AddExerciseTVCell)
}

class AddExerciseTVCell: UITableViewCell {
    
    weak var delegate: AddCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func AddExerciseBtnPressed(_ sender: AddExerciseTVCell) {
        delegate?.didPressButton(self)
    }
}
