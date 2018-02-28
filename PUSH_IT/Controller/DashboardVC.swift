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
    @IBOutlet weak var loadingView: UIView!

    var completePercent = 0
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let loadingScreen = Bundle.main.loadNibNamed(LOAD_SCREEN, owner: self, options: nil)!.first as? LoadingScreen else { return }

        loadingView.addSubview(loadingScreen)
        loadingScreen.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":loadingScreen]))
        loadingView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":loadingScreen]))

        // menu button 
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        username = UserDataService.instance.name
        
        if username == "" {
            greeting.text = "Hello!"
        } else {
            greeting.text = "Hi, \(username)!"
        }
        
        ExerciseDataService.instance.fetchExercisesFromServer { (success) in
            if !success {
                debugPrint("error fetching exercises from server")
            } else {
                self.completePercent += 33
                self.updateProgressBar(pb: loadingScreen.progressBar)
            }
        }

        HistoryDataService.instance.fetchHistory { (success) in
            if !success {
                debugPrint("error fetching history from server")
            } else {
                self.completePercent += 33
                self.updateProgressBar(pb: loadingScreen.progressBar)
            }
        }

        HistoryDataService.instance.fetchSavedWorkouts { (success) in
            if !success {
                debugPrint("error fetching saved workouts from server")
            } else {
                self.completePercent += 34
                self.updateProgressBar(pb: loadingScreen.progressBar)
            }
        }
        
        UserDataService.instance.getUserPrimaryGoal { (success) in
            if !success {
                debugPrint("error fetching primary goal")
            }
        }
        UserDataService.instance.getSecondaryGoals { (success) in
            if !success {
                debugPrint("error getting goals")
            }
        }
    }
    
    // Actions
    @IBAction func workoutNowButtonPressed(_ sender: Any) {
        let newWorkoutVC = self.storyboard?.instantiateViewController(withIdentifier: "NewWorkoutVC")
        
        addChildViewController(newWorkoutVC!)
        self.revealViewController().pushFrontViewController(newWorkoutVC, animated: true)
    }
    
    @IBAction func planWorkoutButtonPressed(_ sender: Any) {
        let newPlanWorkoutVC = self.storyboard?.instantiateViewController(withIdentifier: "PlanWorkoutVC")
        addChildViewController(newPlanWorkoutVC!)
        self.revealViewController().pushFrontViewController(newPlanWorkoutVC, animated: true)
    }
    
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        let newHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "HistoryVC")
        addChildViewController(newHistoryVC!)
        self.revealViewController().pushFrontViewController(newHistoryVC, animated: true)
    }
    
    @IBAction func goalsButtonPressed(_ sender: Any) {
        let newGoalsVC = self.storyboard?.instantiateViewController(withIdentifier: "GoalsVC")
        
        addChildViewController(newGoalsVC!)
        self.revealViewController().pushFrontViewController(newGoalsVC, animated: true)
    }

    func updateProgressBar(pb: UIProgressView) {
        pb.progress = Float(self.completePercent / 100)
        if(pb.progress == 1) {
            self.loadingView.isHidden = true
        }
    }
}
