//
//  OnboardingVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 
    // define outlets
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var levelPicker: UIPickerView!
    @IBOutlet weak var goalPicker: UIPickerView!
    @IBOutlet weak var levelSelectedTxt: UILabel!
    @IBOutlet weak var goalSelectedTxt: UILabel!
    @IBOutlet weak var finishBtn: UIButton!
    
    // define variables
    var firstName = ""
    var selectedLevel = "beginner"
    var selectedGoal = "Get Strong" // defaults
    
    let experienceLevels = ["beginner", "intermediate", "advanced"]
    let primaryGoals = ["Get Strong", "Get Big", "Improve Power"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == levelPicker {
            return experienceLevels.count
        } else if pickerView == goalPicker {
            return primaryGoals.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == levelPicker {
            return experienceLevels[row]
        } else if pickerView == goalPicker {
            return primaryGoals[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == levelPicker {
            selectedLevel = experienceLevels[row]
           levelSelectedTxt.text = selectedLevel
            levelPicker.isHidden = true
            finishBtn.isHidden = false
            
        } else if pickerView == goalPicker {
            selectedGoal = primaryGoals[row]
           goalSelectedTxt.text = selectedGoal
            goalPicker.isHidden = true
            finishBtn.isHidden = false
        }
        return
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelPicker.delegate = self
        goalPicker.delegate = self
        levelPicker.dataSource = self
        goalPicker.dataSource = self
        levelPicker.isHidden = true
        goalPicker.isHidden = true
        
        self.hideKeyboardWhenTappedAround() 

    }
    
    @IBAction func finishBtnClicked(_ sender: Any) {
        
        guard let firstName = firstNameField.text, firstNameField.text != "" else { return }
        
        AuthService.instance.submitOnboardingData(name: firstName, level: selectedLevel, goal: selectedGoal) { (success) in
            if success {
                self.performSegue(withIdentifier: SHOW_SW_REVEAL_FROM_ONBOARDING, sender: nil)
            } else {
                debugPrint("Something went wrong submitting data")
            }
        }
    }
    
    @IBAction func experienceButtonPressed(_ sender: Any) {
        debugPrint("exp level clicked")
        levelPicker.isHidden = false
        finishBtn.isHidden = true
    }
    
    @IBAction func primaryGoalButtonPressed(_ sender: Any) {
        
        debugPrint("goal clicked")
        goalPicker.isHidden = false
        finishBtn.isHidden = true
    }
}
