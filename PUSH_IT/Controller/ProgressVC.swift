//
//  ProgressVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/26/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class ProgressVC: UIViewController, UITableViewDataSource, UITableViewDelegate, ProgressTVCellDataSource {
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var progressTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressTV.dataSource = self
        progressTV.delegate = self
        
        // menu button stuff
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }
    
    // table view methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExerciseDataService.instance.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(PROGRESS_TV_CELL, owner: self, options: nil)?.first as! ProgressTVCell
        
        let exercise = ExerciseDataService.instance.exercises[indexPath.row]
        cell.exerciseName = exercise
        cell.dataSource = self
        
        cell.exerciseNameLbl.text = exercise
        
        cell.loadData()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    // ProgressTVCell Data Source Protocol method
    func loadData(forExercise exercise: String) ->  [String : Int]{
        return HistoryDataService.instance.getHistoryForExercise(exercise: exercise)
    }
    
}
