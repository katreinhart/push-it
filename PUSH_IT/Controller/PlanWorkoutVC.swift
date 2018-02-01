//
//  PlanWorkoutVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/30/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class PlanWorkoutVC: UIViewController, UITableViewDataSource, UITableViewDelegate, SaveWorkoutDelegate, SaveExerciseCellDelegate {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var planWorkoutTV: UITableView!
    
    // Variables
    var exercises = WorkoutDataService.instance.activeWorkout?.exercises

    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planWorkoutTV.dataSource = self
        planWorkoutTV.delegate = self
        
        if WorkoutDataService.instance.activeWorkoutID == nil {
            WorkoutDataService.instance.createNewWorkout()
        }
        
        // Keyboard slide up/down stuff
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // hide keyboard when tapped around
        self.hideKeyboardWhenTappedAround()
        
        // Menu button stuff
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    // Table view methods
    
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
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        if section == 0 {
            let cell = Bundle.main.loadNibNamed(EXERCISE_TV_CELL, owner: self, options: nil)?.first as! ExerciseTVCell
            
            cell.exerciseNameLbl.text = exercises![indexPath.row].type
            cell.weightLbl.text = String(exercises![indexPath.row].goalWeight)
            cell.repsLbl.text = String(exercises![indexPath.row].goalRepsPerSet)
            cell.setsLbl.text = String(exercises![indexPath.row].goalSets)
            
            return cell
        } else if section == 1 {
            let cell = Bundle.main.loadNibNamed(NEW_EX_TV_CELL, owner: self, options: nil)?.first as! NewExerciseTVCell
            
            cell.delegate = self
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed(SAVE_TV_CELL, owner: self, options: nil)?.first as! SaveWorkoutTVCell
            
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        
        if section == 0 {
            return 155.5
        } else if section == 1 {
            return 253
        } else {
            return 64
        }
    }
    
    // Custom delegate methods
    func didPressSaveWorkoutButton(_ sender: SaveWorkoutTVCell) {
        WorkoutDataService.instance.markWorkoutSaved()
        self.performSegue(withIdentifier: BACK_TO_DASHBOARD, sender: nil)
    }
    
    func didPressSaveBtn(_ sender: NewExerciseTVCell, exercise: Exercise) {
        WorkoutDataService.instance.addExerciseToActiveWorkout(exercise: exercise)
        exercises = WorkoutDataService.instance.activeWorkout?.exercises
        self.planWorkoutTV.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    // Keyboard slide up and down functions
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}
