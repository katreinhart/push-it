//
//  Goal.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/21/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation

struct Goal {
    public private(set) var exercise: String!
    public private(set) var weight: Int64!
    public private(set) var date: Date!
    
    func returnAsString() -> String {
        let dateString = date.toString(withFormat: "MMM dd, yyyy")
        return "\(String(exercise)) \(String(weight)) by \(dateString)"
    }
}
