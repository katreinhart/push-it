//
//  EditGoalsVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/21/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class EditGoalsVC: UIViewController {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var primaryGoalTxt: UITextField!
    
    @IBOutlet weak var sg1ExerciseTxt: UILabel!
    @IBOutlet weak var sg2ExerciseTxt: UILabel!
    @IBOutlet weak var sg1WtTxt: UILabel!
    @IBOutlet weak var sg2WtTxt: UILabel!
    @IBOutlet weak var sg1DateTxt: UILabel!
    @IBOutlet weak var sg2DateTxt: UILabel!
    @IBOutlet weak var saveGoalBtn: UIButton!
    
    // Variables
    
    var primaryGoal: String = ""
    var sg1Exercise: String?
    var sg2Exercise: String?
    var sg1Wt: int_least64_t?
    var sg2Wt: int_least64_t?
    var sg1Date: Date?
    var sg2Date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        primaryGoalTxt.text = UserDataService.instance.primaryGoal
        
    menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }
    
    // Actions
    
    // Edit Exercise Buttons
    @IBAction func editSG1ExBtn(_ sender: Any) {
    }
    @IBAction func editSG2ExBtn(_ sender: Any) {
    }

    // Edit Weight Buttons
    @IBAction func editSG1WtBtn(_ sender: Any) {
    }
    @IBAction func editSG2WtBtn(_ sender: Any) {
    }
    
    // Edit Date Buttons
    @IBAction func editSG1DateBtn(_ sender: Any) {
    }
    @IBAction func editSG2DateBtn(_ sender: Any) {
    }
    
    // Save Button Pressed
    @IBAction func saveGoalsBtn(_ sender: Any) {
    }
    
    
}
