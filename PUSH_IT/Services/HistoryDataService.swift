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

// HistoryDataService handles the history and saved workout functions fetching from API.
class HistoryDataService {
    
    // HistoryDataService is a singleton class, so set the instance.
    static let instance = HistoryDataService()
    
    // history and saved are arrays of workout objects
    var history = [Workout]()
    var saved = [Workout]()
    
    // Boolean for displaying the calendar view
    func hasEventforDate(date: Date) -> Bool {
        // Compare short format date strings "mm/dd/yy" for equality, since we don't care about more granular units of time
        
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
    
    // Get History For Exercise takes in a string which is an exercise name, and returns the history of that lift in the format of [datestring: weight]
    func getHistoryForExercise(exercise: String) -> [String: Int] {
        // check to see if the exercise is in ExerciseDataService.instance.exercises
        let index = ExerciseDataService.instance.exercises.index(of: exercise)
        if index == nil {
            // if not found, return a default value of ["":0]
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
    
    func fetchSavedWorkouts() {
        // reset so it doesn't duplicate
        self.saved = [Workout]()
        // Make the request
        Alamofire.request(SAVED_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error != nil {return}
            guard let data = response.data else {return}
            
            let json = JSON(data: data).arrayValue
            
            for item in json {
                let responseExercises = item["exercises"].array
                if responseExercises == nil {continue}
                let dateString = item["created"].stringValue
                debugPrint(dateString)
                let date = DateFormatter.veryLongStringDateFormatter.date(from: dateString)
                let id = item["workout_id"].intValue
                var newWorkout = Workout(exercises: [], id: id, date: date!, rating: 0, comments: "")
                
                for ex in responseExercises! {
                    let exName = ex["exercise_name"].stringValue
                    let goalWt = ex["goal_weight"].intValue
                    let sets = ex["goal_sets"].intValue
                    let reps = ex["goal_reps_per_set"].intValue
                    let newExercise = Exercise(type: exName, goalWeight: goalWt, goalSets: sets, goalRepsPerSet: reps, sets: [])
                    
                    newWorkout.exercises.append(newExercise)
                }
                self.saved.append(newWorkout)
            }
        }
    }
    
    func clearHistory() {
        self.history = [Workout]()
        self.saved = [Workout]()
    }
    
    func fetchHistory() {
        
        // re-instantiate history when fetching so it does not continue adding
        history = [Workout]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ISO_LONG_FORMAT
        
        Alamofire.request(HISTORY_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error != nil {return}
            guard let data = response.data else {return}
            
            let json = JSON(data: data).array
            for item in json! {
                let dateString = item["start_time"].stringValue
                let date = dateFormatter.date(from: dateString)
                
                // ignore history items without valid start time
                if date == nil {continue}
                
                // parse rating and comments from JSON
                let rating = item["rating"].int
                let comments = item["comments"].stringValue
                let id = item["workout_id"].intValue
                
                // create new workout object
                var newWorkout = Workout(exercises: [], id: id, date: date!, rating: rating!, comments: comments)
                
                // parse exercises and sets from JSON
                let responseExercises = item["exercises"].array
                let responseSets = item["sets"].array
                
                // ignore workouts with no exercises or sets
                if responseExercises == nil {continue}
                if responseSets == nil {continue}
                
                for ex in responseExercises! {
                    let exName = ex["exercise_name"].stringValue
                    let sets = ex["goal_sets"].intValue
                    let reps = ex["goal_reps_per_set"].intValue
                    let newExercise = Exercise(type: exName, goalWeight: 0, goalSets: sets, goalRepsPerSet: reps, sets: [])
                    
                    newWorkout.exercises.append(newExercise)
                }
                
                for set in responseSets! {
                    
                    let exName = set["exercise_name"].stringValue
                    let exIndex = newWorkout.exercises.index(where: { (item) -> Bool in
                        return (item.type == exName)
                    })
                    
                    if exIndex == nil {continue}
                    
                    let repsAtt = set["reps_att"].intValue
                    let repsComp = set["reps_comp"].intValue
                    let weight = set["weight"].intValue
                    
                    let newSet = Set(weight: weight, repsCompleted: repsComp, repsAttempted: repsAtt)
                    
                    newWorkout.exercises[exIndex!].sets.append(newSet)
                    newWorkout.exercises[exIndex!].goalWeight = weight
                }
                
                self.history.append(newWorkout)
            }
            
            // Sort the history in descending order
            self.history.sort(by: { (workout1, workout2) -> Bool in
                workout1.date > workout2.date
            })
        }
    }
}
