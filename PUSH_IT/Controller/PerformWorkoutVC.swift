//
//  PerformWorkoutVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/24/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class PerformWorkoutVC: UIViewController {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var exerciseNameLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var repsLbl: UILabel!
    @IBOutlet weak var setsLbl: UILabel!
    
    @IBOutlet weak var currentSetLbl: UILabel!
    
    @IBOutlet weak var repsDoneLbl: UILabel!
    
    @IBOutlet weak var InputWorkoutView: UIView!
    @IBOutlet weak var repsSlider: UISlider!
    
    // Variables
    var currentExercise: String = ""
    var targetWeight: Int = 0
    var targetReps: Int = 0
    var targetSets: Int = 0
    
    var exerciseIndex: Int = 0
    var setIndex: Int = 0
    
    var repsPerformed: Int = 0
    
    var repsDoneLblText = ""
    var currentSetLblText = ""

    
    // Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load current exercise stats
        currentExercise = WorkoutDataService.instance.activeWorkout!.exercises[0].type
        targetWeight = WorkoutDataService.instance.activeWorkout!.exercises[0].goalWeight
        targetReps = WorkoutDataService.instance.activeWorkout!.exercises[0].goalRepsPerSet
        targetSets = WorkoutDataService.instance.activeWorkout!.exercises[0].goalSets
        
        // Load data into view
        exerciseNameLbl.text = currentExercise
        weightLbl.text = String(targetWeight)
        repsLbl.text = String(targetReps)
        setsLbl.text = String(targetSets)
        
        // set up sets and reps labels
        currentSetLblText = "Set \(setIndex + 1) of \(targetSets)"
        currentSetLbl.text = currentSetLblText
        repsDoneLblText = "\(repsPerformed) out of \(targetReps)"
        repsDoneLbl.text = repsDoneLblText
        
        InputWorkoutView.isHidden = true
        
        // Menu button stuff
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    
    
    // Actions
    
    @IBAction func GoBtnPressed(_ sender: Any) {
        InputWorkoutView.isHidden = false
        
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        repsPerformed = Int(repsSlider.value)
        repsDoneLblText = "\(repsPerformed) out of \(targetReps)"
        repsDoneLbl.text = repsDoneLblText
        
    }
    @IBAction func nextBtnPressed(_ sender: Any) {
        WorkoutDataService.instance.performSetOnActiveWorkout(exerciseIndex: exerciseIndex, setIndex: setIndex, repsAttempted: targetReps, repsCompleted: repsPerformed)
        
        
        setIndex += 1
        
        if setIndex == targetSets {
            exerciseIndex += 1
            if exerciseIndex == WorkoutDataService.instance.activeWorkout!.exercises.count {
                debugPrint("You are done! Booyah.")
                return
            }
            else {
                setIndex = 0
                targetWeight = WorkoutDataService.instance.activeWorkout!.exercises[exerciseIndex].goalWeight
                targetReps = WorkoutDataService.instance.activeWorkout!.exercises[exerciseIndex].goalRepsPerSet
                targetSets = WorkoutDataService.instance.activeWorkout!.exercises[exerciseIndex].goalSets
                currentExercise = WorkoutDataService.instance.activeWorkout!.exercises[exerciseIndex].type
                exerciseNameLbl.text = currentExercise
                weightLbl.text = String(targetWeight)
                repsLbl.text = String(targetReps)
                setsLbl.text = String(targetSets)
                
            }
        }
        
        currentSetLblText = "Set \(setIndex + 1) of \(targetSets)"
        currentSetLbl.text = currentSetLblText
    }
}
