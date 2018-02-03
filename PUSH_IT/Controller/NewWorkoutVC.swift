//
//  NewWorkoutVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/22/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class NewWorkoutVC: UIViewController {
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide keyboard when tapped around
        self.hideKeyboardWhenTappedAround()
        
        // Menu btn stuff for SWReveal
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }

    @IBAction func loadWorkoutBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOAD_WORKOUT, sender: nil)
    }
    @IBAction func newWorkoutBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: SHOW_START_NEW_WORKOUT_VC , sender: nil)
    }
}
