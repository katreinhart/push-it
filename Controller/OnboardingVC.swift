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
    
    // define variables
    var firstName = ""
    var selectedLevel = ""
    var selectedGoal = ""
    
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
        } else if pickerView == goalPicker {
            selectedGoal = primaryGoals[row]
        }
        return
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelPicker.delegate = self
        goalPicker.delegate = self
        levelPicker.dataSource = self
        goalPicker.dataSource = self

    }
    @IBAction func finishBtnClicked(_ sender: Any) {
        
        guard let firstName = firstNameField.text, firstNameField.text != "" else { return }
        
        debugPrint(firstName, selectedLevel, selectedGoal)
        
        
    }
    
}
