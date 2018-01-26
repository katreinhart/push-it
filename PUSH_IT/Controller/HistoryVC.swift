//
//  HistoryVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/24/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    

    var history: [Workout] = [Workout]()

    
    // Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var historyTable: UITableView!
    @IBOutlet weak var historyCalendarCV: UICollectionView!
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load history from WorkoutDataService
        
        history = HistoryDataService.instance.history
        
        historyTable.dataSource = self
        historyTable.delegate = self
        historyCalendarCV.dataSource = self
        historyCalendarCV.delegate = self
        
       // Menu button stuff
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    // Table view protocol methods
    
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
    
    // Collection view protocol methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = historyCalendarCV.dequeueReusableCell(withReuseIdentifier: "historyCell", for: indexPath) as! HistoryCell
        let index = indexPath.item
        let daysElapsed = Double(index * 86400)
        let cellDate = Date().threeWeeksAgoSunday?.addingTimeInterval(daysElapsed)
        
        debugPrint("cell date is:", cellDate!)
        
        if HistoryDataService.instance.hasEventforDate(date: cellDate!) {
            cell.background.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        } else {
            cell.background.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
        return cell
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
