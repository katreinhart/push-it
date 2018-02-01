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
    
    // get ready view
    @IBOutlet weak var getReadyView: UIView!
    @IBOutlet weak var weightPlatesLbl: UILabel!
    @IBOutlet weak var weightPlatesStackView: UIStackView!
    @IBOutlet weak var plateGraphicsView: PlateGraphicsView!
    
    // done view outlets
    @IBOutlet weak var doneView: UIView!
    @IBOutlet weak var doneFinishBtn: UIButton!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var betweenSetMessageView: UIVisualEffectView!
    @IBOutlet weak var encouragingMessageLbl: UILabel!
    
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
    
    // done view variables
    var rating = 0
    var comment = ""
    
    // encouraging messages
    // TODO: Randomly display these in the finished view
    var messages = [
        "You crushed it!",
        "Great job!",
        "Way to go!",
        "You're a beast!",
        "H*ck yes!",
        "Great Work!",
        "Way to push it!"
    ]
    
    // Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide done view
        doneView.isHidden = true
        betweenSetMessageView.isHidden = true
        
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
        repsSlider.value = 0
        
        // set up sets and reps labels
        currentSetLblText = "Set \(setIndex + 1) of \(targetSets)"
        currentSetLbl.text = currentSetLblText
        repsDoneLblText = "\(repsPerformed) out of \(targetReps)"
        repsDoneLbl.text = repsDoneLblText
        
       // set up Get Ready view
        
        getReadyView.isHidden = false
        InputWorkoutView.isHidden = true
        weightPlatesLbl.text = WorkoutDataService.instance.getWeightPlatesForWeight(weight: targetWeight)
        
        plateGraphicsView.plates = WorkoutDataService.instance.getWeightPlates(weight: targetWeight)
        
        // hide keyboard
        self.hideKeyboardWhenTappedAround()
        
        // Keyboard slide up/down stuff
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        // Menu button stuff
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
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
        
        self.encouragingMessageLbl.text = displayEncouragement()
        self.betweenSetMessageView.isHidden = false
        
        UIView.animate(withDuration: 2, animations: {
            self.betweenSetMessageView.alpha = 0
        }) { (finished) in
            self.betweenSetMessageView.isHidden = true
            self.betweenSetMessageView.alpha = 1
        }
        setIndex += 1
        
        if setIndex == targetSets {
        
            exerciseIndex += 1
            if exerciseIndex == WorkoutDataService.instance.activeWorkout!.exercises.count {
                // Finished last set!
                
                weightPlatesStackView.isHidden = true
                doneView.isHidden = false
                InputWorkoutView.isHidden = true
                getReadyView.isHidden = true
            }
            else {
                getReadyView.isHidden = false
                InputWorkoutView.isHidden = true
                
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
                plateGraphicsView.reset() 
                plateGraphicsView.plates = WorkoutDataService.instance.getWeightPlates(weight: targetWeight)
                plateGraphicsView.draw(plateGraphicsView.frame)
                
            }
        }
        
        currentSetLblText = "Set \(setIndex + 1) of \(targetSets)"
        currentSetLbl.text = currentSetLblText
    }
    
    @IBAction func ratingSlider(_ sender: Any) {
        rating = Int(ratingSlider.value)
    }
    
    @IBAction func commentField(_ sender: Any) {
        comment = commentField.text ?? ""
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        WorkoutDataService.instance.finishWorkout(comment: comment, rating: rating)
        performSegue(withIdentifier: UNWIND_TO_DASHBOARD, sender: nil)
    }
    
    // Helper function for encouraging messages
    func displayEncouragement() -> (String) {
        let num = Int(arc4random_uniform(UInt32(messages.count)))
        return messages[num]
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
