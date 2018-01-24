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
    
    func performSet(repsAttempted: Int, repsCompleted: Int) {
        
    }
    
    func allRepsAndSetsCompleted(exercise: Exercise) -> Bool {
        return false
    }
}
