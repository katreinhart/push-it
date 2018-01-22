//
//  ExerciseDataService.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/22/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ExerciseDataService {
    static let instance = ExerciseDataService()
    
    public private(set) var exercises: [String] = []
    
    func fetchExercisesFromServer() {
        let header = [
            "Content-Type": "application/json; charset=utf8",
            "Authorization": "Bearer \(AuthService.instance.authToken)"
        ]
        
        Alamofire.request(FETCH_EXERCISES_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data)
                for item in json {
                    let exName = item.1["ex_name"].stringValue
                    self.exercises.append(exName)
                }
            }
        }
    }
    
}
