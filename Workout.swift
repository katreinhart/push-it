//
//  Workout.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/23/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation

struct Workout {
    var exercises: [Exercise]
    var rating: Int
    var comments: String?
}

struct Exercise {
    var type: String
    var goalWeight: Int
    var goalSets: Int
    var goalRepsPerSet: Int
    var sets: [Set]
}

struct Set {
    var weight: Int
    var repsCompleted: Int
    var repsAttempted: Int
}
