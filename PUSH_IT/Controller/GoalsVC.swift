//
//  GoalsVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/21/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class GoalsVC: UIViewController {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var primaryGoalLbl: UILabel!
    @IBOutlet weak var secondaryGoalLbl1: UILabel!
    @IBOutlet weak var secondaryGoalLbl2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        
        primaryGoalLbl.text = UserDataService.instance.primaryGoal
    }
    
    @IBAction func editGoalsBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SHOW_EDIT_GOAL_VC, sender: nil)
    }
    
}
