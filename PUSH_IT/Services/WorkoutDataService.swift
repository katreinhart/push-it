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
        Alamofire.request(CREATE_WORKOUT_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                debugPrint("Workout successfully created")
                guard let data = response.data else { return }
                let json = JSON(data: data)
                
                guard let id = json["id"].string else {return}
                
                self.activeWorkoutID = Int(id)!
                
                let workout = Workout(exercises: [Exercise](), rating: 0, comments: "")
                self.workouts.append(workout)
                self.activeWorkout = workout
            }
        }
    }
    
    func addExerciseToWorkout(workout: Workout, targetWeight: Int, exerciseName: String, exerciseReps: Int, exerciseSets: Int) {
        
        let body = [
            "exercise_name": exerciseName,
            "goal_sets": exerciseSets,
            "goal_reps": exerciseReps
            ] as [String : Any]
        
        let newExercise = Exercise(type: exerciseName, goalWeight: targetWeight, goalSets: exerciseSets, goalRepsPerSet: exerciseReps, sets: [Set]())
        
        activeWorkout?.exercises.append(newExercise)
        
        Alamofire.request("\(BASE_URL)/workouts/\(activeWorkoutID!)/exercises", method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                debugPrint("Something worked")
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
