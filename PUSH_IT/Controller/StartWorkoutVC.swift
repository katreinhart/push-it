//
//  StartWorkoutVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class StartWorkoutVC: UIViewController, UITableViewDelegate, UITableViewDataSource, AddCellDelegate, SaveExerciseCellDelegate {
    
    
   
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var exercises = WorkoutDataService.instance.activeWorkout?.exercises
    public var isAdding = false
    
    // TableView protocol functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if exercises == nil {
                return 0
            } else {
                return exercises!.count
            }
        } else if section == 1 {
            if isAdding {
                return 0
            } else {
                return 1
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        if section == 0 {
            let cell = Bundle.main.loadNibNamed("ExerciseTVCell", owner: self, options: nil)?.first as! ExerciseTVCell
            cell.exerciseName = exercises![indexPath.row].type
            cell.targetWeight = exercises![indexPath.row].goalWeight
            cell.reps = exercises![indexPath.row].goalRepsPerSet
            cell.sets = exercises![indexPath.row].goalSets
            return cell
        } else if section == 1 {
            let cell = Bundle.main.loadNibNamed("NewExerciseTVCell", owner: self, options: nil)?.first as! NewExerciseTVCell
            cell.delegate = self
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("AddExerciseTVCell", owner: self, options: nil)?.first as! AddExerciseTVCell
            cell.delegate = self
            debugPrint("Cell for row at", indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        
        if section == 0 {
            return 155.5
        } else if section == 1 {
            return 241
        } else {
            return 45
        }
    }
    
    // AddCellDelegate protocol
    
    func didPressButton(_ sender: AddExerciseTVCell) {
        debugPrint("didPressButton")
    }
    
    // SaveNewCellDelegate protocol function
    
    func didPressSaveBtn(_ sender: NewExerciseTVCell, exercise: Exercise) {
        debugPrint("Did press save button")
        debugPrint(exercise)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up delegates & data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // Menu btn stuff for SWReveal
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if(WorkoutDataService.instance.activeWorkout == nil) {
            WorkoutDataService.instance.createNewWorkout()
        }
    }
}
