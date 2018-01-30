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

// ExerciseDataService handles fetching the names of exercises available.
// It is a singleton like the other service classes.

class ExerciseDataService {
    static let instance = ExerciseDataService()
    
    public private(set) var exercises: [String] = []
    
    func fetchExercisesFromServer() {
        
        Alamofire.request(FETCH_EXERCISES_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.exercises = [String]()
                
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
