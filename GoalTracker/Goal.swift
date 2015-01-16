//
//  Goal.swift
//  GoalTracker
//
//  Created by Stephen Doyle on 15/01/2015.
//  Copyright (c) 2015 Stephen Doyle. All rights reserved.
//

import Foundation

class Goal: NSObject {
    var activity: String
    var targetDistance: Int
    var distanceUnit: String
    var completedDistance: Float
    
    init(activity: String, targetDistance: Int, distanceUnit: String) {
        self.activity = activity
        self.targetDistance = targetDistance
        self.distanceUnit = distanceUnit
        self.completedDistance = 0.0
        super.init()
    }
    
    func title() -> String {
        return "\(self.activity) \(self.targetDistance) \(self.distanceUnit)"
    }
    
    func percentComplete() -> Float {
        if targetDistance == 0 {
            return 0.0
        }
        return completedDistance / Float(targetDistance) * 100
    }
    
    func distanceRemaining() -> Float {
        if Float(targetDistance) <= completedDistance {
            return 0.0
        }
        return Float(targetDistance) - completedDistance
    }
    
    func updateCompletedDistance(distance: Float) {
        completedDistance += distance
    }
}