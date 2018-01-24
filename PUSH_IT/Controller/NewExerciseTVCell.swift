//
//  NewExerciseTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

protocol SaveExerciseCellDelegate: class {
    func didPressSaveBtn(_ sender: NewExerciseTVCell, exercise: Exercise)
}

class NewExerciseTVCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Outlets
    @IBOutlet weak var exPickedLbl: UILabel!
    @IBOutlet weak var exercisePicker: UIPickerView!
    
    @IBOutlet weak var weightTxt: UITextField!
    @IBOutlet weak var repTxt: UITextField!
    @IBOutlet weak var setsTxt: UITextField!
    
    // Variables
    var selectedExercise: String?
    var targetWeight: Int?
    var targetSets: Int?
    var targetRepsPerSet: Int?
    
    weak var delegate: SaveExerciseCellDelegate?
    
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
        
        // check all values are present
        guard targetWeight != nil else {return}
        guard targetRepsPerSet != nil else {return}
        guard targetSets != nil else {return}
        guard selectedExercise != nil else {return}
        
        let newExercise = Exercise(type: selectedExercise!, goalWeight: targetWeight!, goalSets: targetSets!, goalRepsPerSet: targetRepsPerSet!, sets: [Set]())
        
        delegate?.didPressSaveBtn(self, exercise: newExercise)
        
    }
    @IBAction func didUpdateWeight(_ sender: Any) {
        targetWeight = Int(weightTxt.text!)
    }
    @IBAction func didUpdateReps(_ sender: Any) {
        targetRepsPerSet = Int(repTxt.text!)
    }
    @IBAction func didUpdateSets(_ sender: Any) {
        targetSets = Int(setsTxt.text!)
    }
}
