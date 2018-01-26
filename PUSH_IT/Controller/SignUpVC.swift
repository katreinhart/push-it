//
//  SignUpVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround() 
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard let email = emailField.text , emailField.text != "" else { return }
        guard let pass = passwordField.text , passwordField.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if (success) {
                // perform segue to dashboard
                self.performSegue(withIdentifier: SHOW_ONBOARDING, sender: nil)
            }
        }
    }
}
