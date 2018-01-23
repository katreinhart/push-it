//
//  StartWorkoutVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class StartWorkoutVC: UIViewController {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    // Variables
    let exercises = WorkoutDataService.instance.activeWorkout?.exercises
    
    // TableView protocol functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if WorkoutDataService.instance.activeWorkout == nil {
            WorkoutDataService.instance.createNewWorkout()
            return 1
        }
        if exercises!.count == 0 {
            return 1
        } else {
            return exercises!.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if WorkoutDataService.instance.activeWorkout?.exercises.count == 0 {
//            let cell = Bundle.main.loadNibNamed("AddExerciseTVCell", owner: self, options: nil)?.first as! AddExerciseTVCell
//            return cell
//        } else if indexPath.row < exercises!.count {
//            let cell = Bundle.main.loadNibNamed("ExerciseTVCell", owner: self, options: nil)?.first as! ExerciseTVCell
//            cell.exerciseName = exercises![indexPath.row].type
//            cell.targetWeight = exercises![indexPath.row].goalWeight
//            cell.reps = exercises![indexPath.row].goalRepsPerSet
//            cell.sets = exercises![indexPath.row].goalSets
//            return cell
//        } else if indexPath.row == exercises!.count {
//            let cell = Bundle.main.loadNibNamed("NewExerciseTVCell", owner: self, options: nil)?.first as! NewExerciseTVCell
//            return cell
//        } else {
            let cell = Bundle.main.loadNibNamed("AddExerciseTVCell", owner: self, options: nil)?.first as! AddExerciseTVCell
            return cell
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Menu btn stuff for SWReveal
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if(WorkoutDataService.instance.activeWorkout == nil) {
            WorkoutDataService.instance.createNewWorkout()
        }
    }

}
