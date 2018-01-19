//
//  SignInVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signinButtonPressed(_ sender: Any) {
        debugPrint("Sign up button pressed")
        guard let email = emailField.text , emailField.text != "" else { return }
        guard let pass = passwordField.text , passwordField.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if (success) {
                debugPrint("login success")
                
                // perform segue to dashboard
            } else {
                debugPrint("failed")
            }
        }
        
    }
}
