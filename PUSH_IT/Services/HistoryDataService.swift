//
//  HistoryDataService.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/25/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// HistoryDataService handles the history functions fetching from API.

class HistoryDataService {
    
    static let instance = HistoryDataService()
    
    // history is an array of workout objects
    var history = [Workout]()
    
    // Boolean for displaying the calendar view
    func hasEventforDate(date: Date) -> Bool {
        // Compare short format date strings "mm/dd/yy" for equality
        let stringDate = DateFormatter.shortStringDateFormatter.string(from: date)
        for item in history {
            let itemStringDate = DateFormatter.shortStringDateFormatter.string(from: item.date)
            if stringDate == itemStringDate {
                return true
            }
        }
        return false
    }
    
    // getPBForExercise takes in a string exercise name and returns a date, weight tuple.
    func getPBForExercise(exercise:String) -> (String, Int) {
        let index = ExerciseDataService.instance.exercises.index(of: exercise)
        if index == nil {
            // if not found, return a default value of ["":0] (will check for this at calling)
            return ("", 0)
        }
        
        var maxDate = ""
        var maxWt = 0
        
        for workout in HistoryDataService.instance.history {
            for wkoEx in workout.exercises {
                if wkoEx.type == exercise {
                    let weight = wkoEx.goalWeight
                    let dateStr = DateFormatter.shortStringDateFormatter.string(from: workout.date)
                    
                    if weight > maxWt {
                        maxDate = dateStr
                        maxWt = weight
                    }
                }
            }
        }
        
        return (maxDate, maxWt)
    }
    
    func getHistoryForExercise(exercise: String, fromDate date: String) -> [String: Int] {
        // Takes in a string which is an exercise name, and returns the history of that lift in the format of [datestring: weight]
        // check to see if the exercise is in ExerciseDataService.instance.exercises
        let index = ExerciseDataService.instance.exercises.index(of: exercise)
        if index == nil {
            // if not found, return a default value of ["":0] (will check for this at calling)
            return ["":0]
        }
        // Instantiate the return value
        var returnValue = [String: Int]()
        // then go through history array looking for each instance of that exercise
        for workout in HistoryDataService.instance.history {
            for wkoEx in workout.exercises {
                if wkoEx.type == exercise {
                    let weight = wkoEx.goalWeight
                    let dateStr = DateFormatter.shortStringDateFormatter.string(from: workout.date)
        
                    // each time the exercise is found, add a "date": weight member to the return value
                    
                    returnValue.updateValue(weight, forKey: dateStr)
                }
            }
        }
        
        return returnValue
    }
    
    func fetchHistory() {
        
        // re-instantiate history when fetching so it does not continue adding
        history = [Workout]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ISO_LONG_FORMAT
        
        Alamofire.request(HISTORY_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = JSON(data: data).array
                for item in json! {
                    let dateString = item["start_time"].stringValue
                    var date = dateFormatter.date(from: dateString)
                    
                    if date == nil {
                        debugPrint("date not found")
                        date = Date()
                    }
                    
                    let rating = item["rating"].int
                    let comments = item["comments"].stringValue
                    
                    var newWorkout = Workout(exercises: [], date: date!, rating: rating!, comments: comments)
                    
                    let responseExercises = item["exercises"].array
                    
                    if responseExercises == nil {
                        self.history.append(newWorkout)
                        continue
                    }
                    
                    for ex in responseExercises! {
                        let exName = ex["exercise_name"].stringValue
                        let sets = ex["goal_sets"].intValue
                        let reps = ex["goal_reps_per_set"].intValue
                        let newExercise = Exercise(type: exName, goalWeight: 0, goalSets: sets, goalRepsPerSet: reps, sets: [])
                        
                        newWorkout.exercises.append(newExercise)
                    }
                    
                    let responseSets = item["sets"].array
                    if responseSets == nil {
                        self.history.append(newWorkout)
                        continue
                    }
                    
                    for set in responseSets! {
                        
                        let exName = set["exercise"].stringValue
                        let exIndex = newWorkout.exercises.index(where: { (item) -> Bool in
                            return (item.type == exName)
                        })
                        
                        if exIndex == nil {
                            continue
                        }
                        
                        let repsAtt = set["reps_att"].intValue
                        let repsComp = set["reps_comp"].intValue
                        let weight = set["weight"].intValue
                        let newSet = Set(weight: weight, repsCompleted: repsComp, repsAttempted: repsAtt)
                        
                        newWorkout.exercises[exIndex!].sets.append(newSet)
                        newWorkout.exercises[exIndex!].goalWeight = weight
                    }
                    
                    self.history.append(newWorkout)
                }
                
                self.history.sort(by: { (workout1, workout2) -> Bool in
                    workout1.date > workout2.date
                })
            }
        }
    }
}
