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
    public private(set) var secondaryGoal1 : Goal?
    public private(set) var secondaryGoal2 : Goal?
    
    
    func setUserDataOnLogin(id: String, email: String, name: String, primaryGoal: String, expLevel: String) {
        self.id = id
        self.email = email
        self.name = name
        self.primaryGoal = primaryGoal
        self.expLevel = expLevel
    }
    
    func setSecondaryGoals(goal1: Goal, goal2: Goal) {
        self.secondaryGoal1 = goal1
        self.secondaryGoal2 = goal2
    }
    
    func getSecondaryGoals() {
        AuthService.instance.getSecondaryGoals { (success) in
            if success {
                debugPrint(UserDataService.instance.secondaryGoal1 ?? "anything?")
            } else {
                debugPrint("Did secondary goals get found?")
            }
        }
    }
    
    func updatePrimaryGoal(primaryGoal: String) {
        self.primaryGoal = primaryGoal
        AuthService.instance.updateUserGoal(goal: primaryGoal) {
            (success) in
            if success != false {
                debugPrint("Something went wrong updating primary goal")
            } 
        }
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
