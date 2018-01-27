//
//  PersonalBestsVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/26/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class PersonalBestsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var pbTableView: UITableView!
    
    // Variables
    var bests = [(String, (String, Int))]()
    
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateBests()

        pbTableView.delegate = self
        pbTableView.dataSource = self
        
        // menu button stuff
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    func calculateBests() {
        let exercises = ExerciseDataService.instance.exercises
        for exercise in exercises {
            let best = HistoryDataService.instance.getPBForExercise(exercise: exercise)
            bests.append((exercise, best))
        }
        bests.sort { (one, two) -> Bool in
            let (_, (_, weight1)) = one
            let (_, (_, weight2)) = two
            return weight1 > weight2
        }
        
        bests = bests.filter { (item) -> Bool in
            let (_, (_, weight)) = item
            return weight != 0
        }
        debugPrint(bests)
    }
    
    // Protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PersonalBestTVCell", owner: nil, options: nil)?.first as! PersonalBestTVCell
        
        let (exercise, (date, weight)) = bests[indexPath.row]
        
        cell.exerciseNameLbl.text = exercise
        cell.dateLbl.text = date
        cell.weightLbl.text = String(weight)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
