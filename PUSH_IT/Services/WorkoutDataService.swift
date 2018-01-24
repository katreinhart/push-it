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

class WorkoutDataService {
    
    static let instance = WorkoutDataService()
    static let token = AuthService.instance.authToken
    
    var workouts = [Workout]()
    var workoutNumber = 0
    
    public private(set) var activeWorkout: Workout?
    public private(set) var activeWorkoutID: Int?
    
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
        debugPrint("Create new workout function")
        Alamofire.request(CREATE_WORKOUT_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                debugPrint("Workout successfully created")
                guard let data = response.data else { return }
                let json = JSON(data: data)
                debugPrint(json)
                guard let id = json["ID"].int else {return}
                self.activeWorkoutID = id
                let workout = Workout(exercises: [Exercise](), rating: 0, comments: "")
                self.workouts.append(workout)
                self.activeWorkout = workout
                debugPrint("active workout ready")
            }
        }
    }
    
    func addExerciseToActiveWorkout(exercise: Exercise) {
        debugPrint("Workout data service add exercise function")
        let id = activeWorkoutID!
        debugPrint("active workout id is ", id)
        activeWorkout!.exercises.append(exercise)
        
        let body = [
            "exercise_name": exercise.type,
            "goal_sets": exercise.goalSets,
            "goal_reps": exercise.goalRepsPerSet
            ] as [String : Any]
        
        debugPrint("about to make network request")
        debugPrint(body)
        Alamofire.request("\(BASE_URL)/api/workouts/\(id)/exercises", method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            debugPrint(response)
            if response.result.error == nil {
                debugPrint("Something worked")
                debugPrint(WorkoutDataService.instance.activeWorkout!)
            } else {
                debugPrint("something didn't work")
            }
        }
    }
    
    func performSetOnActiveWorkout(exerciseIndex: Int, setIndex: Int, repsAttempted: Int, repsCompleted: Int) {
        let id = activeWorkoutID!
        if exerciseIndex == activeWorkout!.exercises.count {return}
        let weight = activeWorkout!.exercises[exerciseIndex].goalWeight
        
        let body = [
            "weight": weight,
            "reps_att": repsAttempted,
            "reps_comp": repsCompleted
            ] as [String : Any]
        
        Alamofire.request("\(BASE_URL)/api/workouts/\(id)/exercises/\(exerciseIndex + 1)/sets", method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                debugPrint("Successfully added set")
            } else {
                debugPrint("Something went wrong adding set")
            }
        }
    }
    
    func allRepsAndSetsCompleted(exercise: Exercise) -> Bool {
        return false
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
            plateString += "\(count10)x 10#"
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
        return plateString
    }
}
