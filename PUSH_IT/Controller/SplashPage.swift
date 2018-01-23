//
//  ViewController.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/18/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
// 

import UIKit

class SplashPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if AuthService.instance.isLoggedIn {
            debugPrint("User already logged in")
            performSegue(withIdentifier: "alreadyLoggedInShowDashboard", sender: nil)
        }
    }

}

