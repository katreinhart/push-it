//
//  WorkoutDataService.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// WorkoutDataService handles posting and fetching workout data from the API.

class WorkoutDataService {
    
    static let instance = WorkoutDataService()
    
    var workouts = [Workout]()
    var workoutNumber = 0
    
    public private(set) var activeWorkout: Workout?
    public private(set) var activeWorkoutID: Int?
    public private(set) var activeExerciseID: Int?
    
    func getWorkoutWithId(id: Int) -> Workout? {
        if(id < workouts.count) {
            return workouts[id]
        } else {
            return nil
        }
    }
    
    func createNewWorkout() {
        let body = [
            "rating": 0,
            "comments": ""
            ] as [String : Any]
        
        Alamofire.request(CREATE_WORKOUT_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error != nil {return}
            guard let data = response.data else { return }
            
            let json = JSON(data: data)
            guard let id = json["ID"].int else {return}
            
            self.activeWorkoutID = id
            let workout = Workout(exercises: [Exercise](), date: Date(), rating: 0, comments: "")
            self.workouts.append(workout)
            self.activeWorkout = workout
        }
    }
    
    func addExerciseToActiveWorkout(exercise: Exercise) {
        let id = activeWorkoutID!
        activeWorkout!.exercises.append(exercise)
        
        let body = [
            "exercise_name": exercise.type,
            "goal_weight": exercise.goalWeight,
            "goal_sets": exercise.goalSets,
            "goal_reps": exercise.goalRepsPerSet
            ] as [String : Any]
        
        
        Alamofire.request("\(BASE_URL)/api/workouts/\(id)/exercises", method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error != nil {
                debugPrint("something went wrong adding exercise")
            } else {
                debugPrint("added exercise to workout")
            }
        }
    }
    
    func performSetOnActiveWorkout(exerciseIndex: Int, setIndex: Int, repsAttempted: Int, repsCompleted: Int) {
        let id = activeWorkoutID!
        if exerciseIndex == activeWorkout!.exercises.count {return}
        let weight = activeWorkout!.exercises[exerciseIndex].goalWeight
        let exerciseName = activeWorkout!.exercises[exerciseIndex].type
        
        
        let body = [
            "exercise_name": exerciseName,
            "weight": weight,
            "reps_att": repsAttempted,
            "reps_comp": repsCompleted
            ] as [String : Any]
        
        Alamofire.request("\(BASE_URL)/api/workouts/\(id)/exercises/sets", method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error != nil {
                debugPrint("Something went wrong adding set")
            }
        }
    }
    
    func finishWorkout(comment: String?, rating: Int) {
        let id = activeWorkoutID!
        let body = [
            "completed": true,
            "rating": rating,
            "comment": comment ?? ""
        ] as [String: Any]
        
        Alamofire.request("\(BASE_URL)/api/workouts/\(id)", method: .put, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error != nil {
                debugPrint("Something went wrong completing workout")
            }
        }
        
        let startTime = DateFormatter.veryLongStringDateFormatter.string(from: activeWorkout!.date)
        let finishTime = DateFormatter.veryLongStringDateFormatter.string(from: Date.init())
        
        debugPrint(startTime)
        debugPrint(finishTime)
        
        let newBody = [
            "started_at": startTime,
            "finished_at": finishTime
        ] as [String: Any]
        
        debugPrint("completing workout number \(id), sending request")
        Alamofire.request("\(BASE_URL)/api/workouts/\(id)", method: .patch, parameters: newBody, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error != nil {
                debugPrint("Something went wrong updating timestamps")
            }
        }
        
        // reset active workout to nil when workout has been completed
        activeWorkoutID = nil
        activeWorkout = nil
    }
    
    func markWorkoutSaved() {
        // reset active workout to nil when workout has been completed
        activeWorkoutID = nil
        activeWorkout = nil
    }
    
    func getSavedWorkouts() {
        Alamofire.request(SAVED_URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error != nil {
                debugPrint("error fetching saved workouts")
            }
        }
    }
    
    func clearHistory() {
        self.workouts = [Workout]()
    }
    
    func setActiveWorkout(workout: Workout) {
        self.activeWorkout = workout
        self.workouts.append(workout)
        self.activeWorkoutID = workouts.count - 1
    }
    
    func getWeightPlates(weight: Int) -> [Int] {
        var plates = [Int]()
        
        let barWeight = 45
        let remaining = weight - barWeight
        var perSide = Int(remaining / 2)
        
        while perSide >= 45 {
            plates.append(45)
            perSide -= 45
        }
        if perSide >= 35 {
            plates.append(35)
            perSide -= 35
        }
        if perSide >= 25 {
            plates.append(25)
            perSide -= 25
        }
        while perSide >= 10 {
            plates.append(10)
            perSide -= 10
        }
        if perSide >= 5 {
            plates.append(5)
            perSide -= 5
        }
        if perSide >= 2 {
            plates.append(2)
            perSide -= 2
        }
        
        return plates
    }
    
    func getWeightPlatesForWeight(weight: Int) -> String {
        var plateString = ""
        let barWeight = 45
        let remaining = weight - barWeight
        var perSide = Int(remaining / 2)
        
        var count45 = 0
        
        while perSide >= 45 {
            count45 += 1
            perSide -= 45
        }
        if count45 > 1 {
            plateString += "\(count45)x 45#, "
        } else if count45 == 1 {
            plateString += "45#, "
        }
        if perSide >= 35 {
            plateString += "35#, "
            perSide -= 35
        }
        if perSide >= 25 {
            plateString += "25#, "
            perSide -= 25
        }
        var count10 = 0
        while perSide >= 10 {
            count10 += 1
            perSide -= 10
        }
        if count10 > 1 {
            plateString += "\(count10)x 10#, "
        } else if count10 == 1 {
            plateString += "10#, "
        }
        if perSide >= 5 {
            plateString += "5#, "
            perSide -= 5
        }
        if perSide > 1 {
            plateString += "2.5#, "
            perSide = 0
        }
        
        if plateString.count > 2 {
            plateString.remove(at: plateString.index(before: plateString.endIndex))
            plateString.remove(at: plateString.index(before: plateString.endIndex))
        }
        return plateString
    }
}
