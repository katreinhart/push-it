//
//  MenuVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

    @IBAction func workoutMenuButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SHOW_WORKOUT_FROM_MENU, sender: nil)
    }
    
    @IBAction func dashboardButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SHOW_DASHBOARD_FROM_MENU, sender: nil)
    }
    
    @IBAction func goalsMenuButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SHOW_GOALS_FROM_MENU, sender: nil)
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SHOW_HISTORY_FROM_MENU, sender: nil)
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        self.performSegue(withIdentifier: SHOW_SPLASH, sender: nil)
    }
}
