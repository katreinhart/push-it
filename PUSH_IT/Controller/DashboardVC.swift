//
//  DashboardVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        username = UserDataService.instance.name
        greeting.text = "Hi, \(username)!"
        
        ExerciseDataService.instance.fetchExercisesFromServer()
        AuthService.instance.getSecondaryGoals { (success) in
            debugPrint(UserDataService.instance.secondaryGoal1 as Any, UserDataService.instance.secondaryGoal2 as Any)
        }
    }
    
    // Actions
    @IBAction func workoutNowButtonPressed(_ sender: Any) {
        let newWorkoutVC = self.storyboard?.instantiateViewController(withIdentifier: "NewWorkoutVC")
        
        addChildViewController(newWorkoutVC!)
        self.revealViewController().pushFrontViewController(newWorkoutVC, animated: true)
    }
    
    @IBAction func goalsButtonPressed(_ sender: Any) {
        let newGoalsVC = self.storyboard?.instantiateViewController(withIdentifier: "GoalsVC")
        
        addChildViewController(newGoalsVC!)
        self.revealViewController().pushFrontViewController(newGoalsVC, animated: true)
    }
    
}
