//
//  DashboardVC.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        
        username = UserDataService.instance.name
        greeting.text = "Hi, \(username)!"
    }

}
