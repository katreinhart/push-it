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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: LOGGED_IN_KEY) {
            let next = self.storyboard?.instantiateViewController(withIdentifier: REVEAL_VC)
            self.present(next!, animated: true, completion: nil)
        }
    }
    
    @IBAction func logInBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    @IBAction func SignUpBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: TO_REGISTER, sender: nil)
    }
}
