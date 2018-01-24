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
    @IBOutlet weak var getReadyView: UIView!
    @IBOutlet weak var weightPlatesLbl: UILabel!
    
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
    var platesLblText = ""
    
    // Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load current exercise stats
        currentExercise = WorkoutDataService.instance.activeWorkout!.exercises[0].type
        targetWeight = WorkoutDataService.instance.activeWorkout!.exercises[0].goalWeight
        targetReps = WorkoutDataService.instance.activeWorkout!.exercises[0].goalRepsPerSet
        targetSets = WorkoutDataService.instance.activeWorkout!.exercises[0].goalSets
        
        // Load data into main view
        exerciseNameLbl.text = currentExercise
        weightLbl.text = String(targetWeight)
        repsLbl.text = String(targetReps)
        setsLbl.text = String(targetSets)
        
        // set up slider
        repsSlider.maximumValue = Float(targetReps)
        repsSlider.isContinuous = false
        
        // set up sets and reps labels
        currentSetLblText = "Set \(setIndex + 1) of \(targetSets)"
        currentSetLbl.text = currentSetLblText
        repsDoneLblText = "\(repsPerformed) out of \(targetReps)"
        repsDoneLbl.text = repsDoneLblText
        
       // set up Get Ready view
        
        getReadyView.isHidden = false
        InputWorkoutView.isHidden = true
        weightPlatesLbl.text = WorkoutDataService.instance.getWeightPlatesForWeight(weight: targetWeight)
        
        // Menu button stuff
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    
    
    // Actions
    
    @IBAction func GoBtnPressed(_ sender: Any) {
        InputWorkoutView.isHidden = false
        getReadyView.isHidden = true
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
                getReadyView.isHidden = false
                
                // reset to first set of exercise
                setIndex = 0
                
                // upate current exercise
                currentExercise = WorkoutDataService.instance.activeWorkout!.exercises[exerciseIndex].type

                // update targets
                targetWeight = WorkoutDataService.instance.activeWorkout!.exercises[exerciseIndex].goalWeight
                targetReps = WorkoutDataService.instance.activeWorkout!.exercises[exerciseIndex].goalRepsPerSet
                targetSets = WorkoutDataService.instance.activeWorkout!.exercises[exerciseIndex].goalSets
                
                // update labels
                exerciseNameLbl.text = currentExercise
                weightLbl.text = String(targetWeight)
                repsLbl.text = String(targetReps)
                setsLbl.text = String(targetSets)
                
                // update slider
                repsSlider.maximumValue = Float(targetReps)
                
                // update plate weights
                platesLblText = WorkoutDataService.instance.getWeightPlatesForWeight(weight: targetWeight)
                weightPlatesLbl.text = platesLblText
            }
        }
        
        currentSetLblText = "Set \(setIndex + 1) of \(targetSets)"
        currentSetLbl.text = currentSetLblText
    }
}
