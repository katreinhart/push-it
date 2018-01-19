//
//  UserDataService.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    public private(set) var primaryGoal = ""
    public private(set) var expLevel = ""
    
    
    func setUserData(id: String, email: String, name: String, primaryGoal: String, expLevel: String) {
        self.id = id
        self.email = email
        self.name = name
        self.primaryGoal = primaryGoal
        self.expLevel = expLevel
        
        debugPrint("User \(self.id) name \(self.name) is a \(self.expLevel) who wants to \(self.primaryGoal)")
    }
    
    func logoutUser() {
        id = ""
        email = ""
        name = ""
        primaryGoal = ""
        expLevel = ""
        
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
}
