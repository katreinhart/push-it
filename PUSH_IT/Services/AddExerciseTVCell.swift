//
//  AddExerciseTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class AddExerciseTVCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func AddExerciseBtnPressed(_ sender: Any) {
        debugPrint("add exercise button pressed")
    }
    
//    func addRowToTable () {
//        // Adding the new row to update the tableView
//        let MyStartWorkoutVC = self.presentingViewController?.presentingViewController?.presentingViewController as! StartWorkoutVC
//        let newExercise = 
//        MyStartWorkoutVC.exercises.insert(, at: 0)
//        MyStartWorkoutVC.myMaterials = (swim.materialsLocal?.allObjects as! [MaterialLocal]).sorted(by: {$0.createdAtLocal! > $1.createdAtLocal!})
//        MyStartWorkoutVC.tableView.reloadData()
//        MyStartWorkoutVC.dismiss(animated: true, completion: nil)
//    }
    
}
