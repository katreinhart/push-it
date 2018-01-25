//
//  HistoryVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/24/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var history: [Workout] = [Workout]()

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load history from WorkoutDataService
        
        history = HistoryDataService.instance.history
        
        historyTable.dataSource = self
        historyTable.delegate = self
        
       // Menu button stuff
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
             return history.count
        } else {
           return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell = Bundle.main.loadNibNamed("HistoryItemTVCell", owner: self, options: nil)?.first as! HistoryItemTVCell
            let workout = history[indexPath.row]
            cell.workoutDateLbl.text = workout.date.toString(withFormat: "MMM dd, yyyy")
        
        if workout.exercises.count == 0 {
            cell.ex1NameLbl.text = ""
            cell.ex1WtLbl.text = ""
            cell.ex1RepsLbl.text = ""
            
            cell.ex2NameLbl.text = ""
            cell.ex2WtLbl.text = ""
            cell.ex2RepsLbl.text = ""
            
            cell.ex3NameLbl.text = ""
            cell.ex3WtLbl.text = ""
            cell.ex3RepsLbl.text = ""
            
            return cell
        }
        
        cell.ex1NameLbl.text = workout.exercises[0].type
        cell.ex1WtLbl.text = String(workout.exercises[0].goalWeight)
        cell.ex1RepsLbl.text = repsToString(exercise: workout.exercises[0])
        
        if workout.exercises.count == 1 {
            cell.ex2NameLbl.text = ""
            cell.ex2WtLbl.text = ""
            cell.ex2RepsLbl.text = ""
            
            cell.ex3NameLbl.text = ""
            cell.ex3WtLbl.text = ""
            cell.ex3RepsLbl.text = ""
            
            return cell
        }
        cell.ex2WtLbl.text = String(workout.exercises[1].goalWeight)
        cell.ex2NameLbl.text = workout.exercises[1].type
        cell.ex2RepsLbl.text = repsToString(exercise: workout.exercises[1])
        
        if workout.exercises.count == 2 {
            cell.ex3NameLbl.text = ""
            cell.ex3WtLbl.text = ""
            cell.ex3RepsLbl.text = ""
            
            return cell
        }
        
        cell.ex3NameLbl.text = workout.exercises[2].type
        cell.ex3WtLbl.text = String(workout.exercises[2].goalWeight)
        cell.ex3RepsLbl.text = repsToString(exercise: workout.exercises[2])
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 162.5
        }
        return 146
    }
    
    func repsToString(exercise: Exercise) -> String {
        var string = ""
        
        for item in exercise.sets {
            string += String(item.repsCompleted)
            string += "/"
        }
        return string
    }
}
