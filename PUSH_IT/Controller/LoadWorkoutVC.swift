//
//  LoadWorkoutVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 2/3/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class LoadWorkoutVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var savedWorkoutsTV: UITableView!
    @IBOutlet weak var menuBtn: UIButton!
    
    // Variables
    var savedWorkouts = [Workout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedWorkouts = HistoryDataService.instance.saved
        
        savedWorkoutsTV.dataSource = self
        savedWorkoutsTV.delegate = self
        
        // Menu btn stuff for SWReveal
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    // Protocol methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workout = savedWorkouts[indexPath.row]
        let cell = Bundle.main.loadNibNamed(LOAD_WORKOUT_TV_CELL, owner: self, options: nil)?.first as! LoadWorkoutTVCell
        let dateString = DateFormatter.medStringDateFormatter.string(from: workout.date)
        cell.dateLbl.text = dateString
        cell.ex1Lbl.text = workout.exercises[0].type
        cell.ex2Lbl.text = workout.exercises.count > 1 ? workout.exercises[1].type : ""
        cell.ex3Lbl.text = workout.exercises.count > 2 ? workout.exercises[2].type : ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = savedWorkouts[indexPath.row]
        WorkoutDataService.instance.setActiveWorkout(workout: workout)
        self.performSegue(withIdentifier: PERFORM_SAVED_WORKOUT, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let workout = savedWorkouts[indexPath.row]
        if workout.exercises.count <= 1 {
            return 65
        } else if workout.exercises.count == 2 {
            return 95
        }
        return 125
    }
    
}
