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
        self.hideKeyboardWhenTappedAround() 
    }

    @IBAction func signinButtonPressed(_ sender: Any) {
        guard let email = emailField.text , emailField.text != "" else { return }
        guard let pass = passwordField.text , passwordField.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if (success) {
                self.performSegue(withIdentifier: SHOW_SW_REVEAL, sender: nil)
                
            } else {
                debugPrint("failed")
            }
        }
    }
    @IBAction func notYetRegisteredClicked(_ sender: Any) {
        self.performSegue(withIdentifier: TO_REGISTER, sender: nil)
    }
}
