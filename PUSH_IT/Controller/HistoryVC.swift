//
//  HistoryVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/24/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Variables
    
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
        
        // collection view setup
        historyCalendarCV?.collectionViewLayout = columnLayout
        
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
        cell.workoutDateLbl.text = DateFormatter.medStringDateFormatter.string(from: workout.date)
        
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
    
    // Collection view variables
    let columnLayout = HistoryCellFlowLayout(
        cellsPerRow: 7,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    )
    
    // Collection view protocol methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Always show 4 weeks of training data
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = historyCalendarCV.dequeueReusableCell(withReuseIdentifier: "historyCell", for: indexPath) as! HistoryCell
        let index = indexPath.item
        let daysElapsed = Double(index * 86400)
        let cellDate = Date().threeWeeksAgoSunday?.addingTimeInterval(daysElapsed)
        
        if HistoryDataService.instance.hasEventforDate(date: cellDate!) {
            cell.background.backgroundColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0.6588235294, alpha: 1)
        } else if cellDate! > Date() {
            // cellDate is in the future
            cell.background.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        } else {
            cell.background.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        
        return cell
    }
    
    // Helper function for creating string out of reps/sets
    func repsToString(exercise: Exercise) -> String {
        var setString = ""
        
        for item in exercise.sets {
            setString += String(item.repsCompleted)
            setString += "/"
        }
        
        // remove the last "/"
        if(setString.count > 1) {
            setString.remove(at: setString.index(before: setString.endIndex))
        }
        
        return setString
    }
}
