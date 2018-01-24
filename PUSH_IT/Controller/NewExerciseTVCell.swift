//
//  NewExerciseTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class NewExerciseTVCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Outlets
    @IBOutlet weak var exPickedLbl: UILabel!
    @IBOutlet weak var exercisePicker: UIPickerView!
    
    @IBOutlet weak var weightTxt: UITextField!
    @IBOutlet weak var repTxt: UITextField!
    @IBOutlet weak var setsTxt: UITextField!
    
    // Variables
    var selectedExercise: String?
    var targetWeight: Int = 0
    var targetSets: Int = 0
    var targetRepsPerSet: Int = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ExerciseDataService.instance.exercises.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ExerciseDataService.instance.exercises[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedExercise = ExerciseDataService.instance.exercises[row]
        exercisePicker.isHidden = true
        exPickedLbl.text = selectedExercise
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exercisePicker.isHidden = true
        exercisePicker.dataSource = self
        exercisePicker.delegate = self
    }

    @IBAction func selectExerciseBtnClicked(_ sender: Any) {
        if(exercisePicker.isHidden) {
            exercisePicker.isHidden = false
        } else {
            exercisePicker.isHidden = true
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let repsSelectedTxt = repTxt.text  else {return}
        guard let setsSelectedTxt = setsTxt.text  else {return}
        guard let weightSelectedTxt = weightTxt.text else {return}
        
        guard Int(weightSelectedTxt) != nil else {return}
        guard Int(repsSelectedTxt) != nil else {return}
        guard Int(setsSelectedTxt) != nil else {return}
        
        guard (selectedExercise != nil) else {return}
        
        WorkoutDataService.instance.addExerciseToWorkout(workout: WorkoutDataService.instance.activeWorkout!, targetWeight: Int(weightSelectedTxt)!, exerciseName: selectedExercise!, exerciseReps: Int(repsSelectedTxt)!, exerciseSets: Int(setsSelectedTxt)!)
        
        
    }
}
