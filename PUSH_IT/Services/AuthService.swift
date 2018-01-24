//
//  AuthService.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.string(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.string(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    var id : Int {
        get {
            return defaults.integer(forKey: USER_ID)
        }
        set {
            defaults.set(newValue, forKey: USER_ID)
        }
    }
    
    
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                self.userEmail = json["email"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func submitOnboardingData(name: String, level: String, goal: String, completion: @escaping CompletionHandler) {
        
        let body: [String: Any] = [
            "email": userEmail,
            "name": name,
            "level": level,
            "goal": goal
        ]
        
        Alamofire.request(SET_INFO_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                self.setUserInfo(data: data)
                
                completion(true)
            }
        }
    }
    
    func setUserInfo(data: Data) {
        let json = JSON(data: data)
        let id = json["id"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        let expLevel = json["level"].stringValue
        let primaryGoal = json["goal"].stringValue
        let token = json["token"].stringValue

        self.authToken = token
        
        UserDataService.instance.setUserDataOnLogin(id: id, email: email, name: name, primaryGoal: primaryGoal, expLevel: expLevel)
        
    }
    
    
    
    func getSecondaryGoals(completion: @escaping CompletionHandler) {
        if self.isLoggedIn == false {
            completion(false)
        } else {
            Alamofire.request(SECONDARY_GOALS_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    let json = JSON(data: data)
                    let responseData = json["data"]
                    
//                    Date stuff is causing issues here
//                    let df = DateFormatter()
//
//                    guard let ds1 = json[0]["goal_date"].string else {return}
//                    let date1 = df.date(from: ds1)
//                    guard let ds2 = json[1]["goal_date"].string else {return}
//                    let date2 = df.date(from: ds2)
                    
                    let gw1 = responseData[0]["goal_weight"].int64!
                    let gw2 = responseData[1]["goal_weight"].int64!
                    
                    let goal1 = Goal(exercise: responseData[0]["exercise"].string, weight: gw1, date: Date())
                    let goal2 = Goal(exercise: responseData[1]["exercise"].string, weight: gw2, date: Date())
                    
                    UserDataService.instance.setSecondaryGoals(goal1: goal1, goal2: goal2)
                    completion(true)
                } else {
                    completion(false)
                    debugPrint("did goals not get found?")
                }
            }
        }
    }
    
    func setSecondaryGoals(sg1: Goal, sg2: Goal, completion: @escaping CompletionHandler) {
        let body: [String: Any] = [
            "goal1": [
                "uid": String(self.id),
                "goal_date": sg1.date.toString(withFormat: "MMM dd, yyyy"),
                "goal_weight": String(sg1.weight),
                "exercise": sg1.exercise
            ],
            "goal2": [
                "uid": String(self.id),
                "goal_date": sg2.date.toString(withFormat: "MMM dd, yyyy"),
                "goal_weight": String(sg2.weight),
                "exercise": sg2.exercise
            ]
        ]
        
        Alamofire.request(SECONDARY_GOALS_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                let json = JSON(data: data)
                let message = json["message"]
                if message == "Goals added successfully" {
                    completion(true)
                }
            } else {
                completion(false)
            }
            debugPrint("Secondary goals posted to db")
        }
    }
    
    func updateUserGoal(goal: String, completion: @escaping CompletionHandler) {
        
        let body = [
            "goal": goal
        ]
        
        Alamofire.request(UPDATE_PRIMARY_GOAL_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {
            (response) in
            if response.result.error != nil {
                completion(false)
            } else {
                debugPrint("pgoal successfully updated")
            }
        }
    }

}
