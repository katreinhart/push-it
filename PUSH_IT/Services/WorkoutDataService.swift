//
//  WorkoutDataService.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation
import Alamofire

struct Workout {
    var exercises: [Exercise]
    var rating: Int
    var comments: String?
}

struct Exercise {
    var type: String
    var goalSets: Int
    var goalRepsPerSet: Int
    var sets: [Set]
}

struct Set {
    var repsCompleted: Int
    var repsAttempted: Int
}

class WorkoutDataService {
    
    static let instance = WorkoutDataService()
    
    static let token = AuthService.instance.authToken
    
    var workouts = [Workout]()
    var workoutNumber = 0
    
    func getWorkoutWithId(id: Int) -> Workout? {
        if(id < workouts.count) {
            return workouts[id]
        } else {
            return nil
        }
    }
    
    func createNewWorkout() {
        
    }
    
    func addExerciseToWorkout(workout: Workout) {
        
    }
    
    func performSet(repsAttempted: Int, repsCompleted: Int) {
        
    }
    
    func allRepsAndSetsCompleted(exercise: Exercise) -> Bool {
        return false
    }
}
