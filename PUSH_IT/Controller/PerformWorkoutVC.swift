//
//  PerformWorkoutVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/24/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class PerformWorkoutVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Menu button stuff
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    
}
