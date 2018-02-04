//
//  EditGoalsVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/21/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class EditGoalsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var primaryGoalTxt: UITextField!
    @IBOutlet weak var sg1ExerciseTxt: UILabel!
    @IBOutlet weak var sg2ExerciseTxt: UILabel!

    @IBOutlet weak var sg1WtTxt: UITextField!
    @IBOutlet weak var sg2WtTxt: UITextField!
    
    @IBOutlet weak var sg1DateTxt: UILabel!
    @IBOutlet weak var sg2DateTxt: UILabel!
    
    @IBOutlet weak var saveGoalBtn: UIButton!
    
    //  Picker outlets
    @IBOutlet weak var exercise1Picker: UIPickerView!
    @IBOutlet weak var exercise2Picker: UIPickerView!
   
    @IBOutlet weak var date1Picker: UIDatePicker!
    @IBOutlet weak var date2Picker: UIDatePicker!
    
    @IBOutlet weak var primaryGoalPicker: UIPickerView!
    
    // Variables
    
    var primaryGoal: String = ""
    var sg1Exercise: String?
    var sg2Exercise: String?
    var sg1Wt: String?
    var sg2Wt: String?
    var sg1Date: Date?
    var sg2Date: Date?
    
    // Picker View Data Sources
    
    var exercises : [String] = []
    let primaryGoals = ["Get Strong", "Get Big", "Improve Power"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        primaryGoalTxt.text = UserDataService.instance.primaryGoal
        
        // set delegates & data sources for pickers
        exercise1Picker.delegate = self
        exercise1Picker.dataSource = self
        exercise2Picker.delegate = self
        exercise2Picker.dataSource = self
        primaryGoalPicker.delegate = self
        primaryGoalPicker.dataSource = self
        
        // Menu button handler 
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        // Hide pickers by default
        exercise1Picker.isHidden = true
        exercise2Picker.isHidden = true
        date1Picker.isHidden = true
        date2Picker.isHidden = true
        primaryGoalPicker.isHidden = true
        
        // Show save button by default
        saveGoalBtn.isHidden = false
        
        // Get exercises from EDS
        exercises = ExerciseDataService.instance.exercises
        
        // keyboard thing
        self.hideKeyboardWhenTappedAround()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == exercise1Picker {
            return self.exercises.count
        } else if pickerView == exercise2Picker {
            return self.exercises.count
        } else {
            return primaryGoals.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == exercise1Picker {
            return exercises[row]
        } else if pickerView == exercise2Picker {
            return exercises[row]
        } else {
            return primaryGoals[row]
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == exercise1Picker {
            sg1Exercise = self.exercises[row]
            exercise1Picker.isHidden = true
            sg1ExerciseTxt.text = sg1Exercise
            saveGoalBtn.isHidden = false
        } else if pickerView == exercise2Picker {
            sg2Exercise = self.exercises[row]
            exercise2Picker.isHidden = true
            sg2ExerciseTxt.text = sg2Exercise
            saveGoalBtn.isHidden = false
        } else {
            primaryGoal = self.primaryGoals[row]
            primaryGoalTxt.text = primaryGoal
            primaryGoalPicker.isHidden = true
            saveGoalBtn.isHidden = false
        }
    }
    
    
    
    // Actions
    
    // Primary Goal Button
    @IBAction func primaryGoalBtn(_ sender: Any) {
        saveGoalBtn.isHidden = true
        primaryGoalPicker.isHidden = false
    }
    
    
    // Edit Exercise Buttons
    @IBAction func editSG1ExBtn(_ sender: Any) {
        saveGoalBtn.isHidden = true
        exercise1Picker.isHidden = false
    }
    @IBAction func editSG2ExBtn(_ sender: Any) {
        saveGoalBtn.isHidden = true
        exercise2Picker.isHidden = false
    }
    
    // Edit Weight Fields
    @IBAction func editSG1Wt(_ sender: Any) {
        sg1Wt = sg1WtTxt.text
    }
    
    @IBAction func editSG2Wt(_ sender: Any) {
        sg2Wt = sg2WtTxt.text
    }
    
    // Edit Date Buttons
    @IBAction func editSG1DateBtn(_ sender: Any) {
        if(date1Picker.isHidden) {
            saveGoalBtn.isHidden = true
            date1Picker.isHidden = false
        } else {
            saveGoalBtn.isHidden = false
            date1Picker.isHidden = true
            let dateString = DateFormatter.medStringDateFormatter.string(from: date1Picker.date)
            sg1DateTxt.text = dateString
            sg1Date = date1Picker.date
        }
    }
    
    @IBAction func editSG2DateBtn(_ sender: Any) {
        if(date2Picker.isHidden) {
            saveGoalBtn.isHidden = true
            date2Picker.isHidden = false
        } else {
            saveGoalBtn.isHidden = false
            date2Picker.isHidden = true
            let dateString = DateFormatter.medStringDateFormatter.string(from: date2Picker.date)
            sg2DateTxt.text = dateString
            sg2Date = date2Picker.date
        }
    }
    
    // Save Button Pressed
    @IBAction func saveGoalsBtn(_ sender: Any) {
        
        // check to make sure all necessary variables have values
        if primaryGoal == "" {return}
        if sg1Exercise == nil {return}
        if sg2Exercise == nil {return}
        if sg1Wt == nil {return}
        if sg2Wt == nil {return}
        if sg1Date == nil {return}
        if sg2Date == nil {return}
        
        // make sure values in weights are convertible to int64
        guard let sg1WtInt = Int64(sg1Wt!) else {return}
        guard let sg2WtInt = Int64(sg2Wt!) else {return}
        
        // create goals out of necessary variables
        let sg1 = Goal(exercise: sg1Exercise!, weight: sg1WtInt, date: sg1Date!)
        let sg2 = Goal(exercise: sg2Exercise!, weight: sg2WtInt, date: sg2Date!)
        
        UserDataService.instance.setSecondaryGoals(sg1: (sg1), sg2: sg2) {
            (success) in
            if success {
                debugPrint("Successfully set secondary goals")
            } else {
                debugPrint("something went wrong setting secondary goals")
            }
        }
        UserDataService.instance.updateUserGoal(goal: primaryGoal) {
            (success) in
            if success {
                debugPrint("Success updating primary goal")
            } else {
                debugPrint("somethign went wrong updating primary goal")
            }
        }
        
        self.performSegue(withIdentifier: UNWIND_TO_DASHBOARD_FROM_SET_GOALS, sender: self)
    }  
    
}
