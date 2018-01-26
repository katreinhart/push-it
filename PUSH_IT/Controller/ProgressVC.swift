//
//  ProgressVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/26/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class ProgressVC: UIViewController, UITableViewDataSource, UITableViewDelegate, ProgressChartDelegate {

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
        let cell = Bundle.main.loadNibNamed("ProgressTVCell", owner: self, options: nil)?.first as! ProgressTVCell
        cell.exerciseNameLbl.text = ExerciseDataService.instance.exercises[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    // ProgressChartDelegate method
    
    func renderChart() {
        
    }
}
