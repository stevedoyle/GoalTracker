//
//  Goal.swift
//  GoalTracker
//
//  Created by Stephen Doyle on 18/01/2015.
//  Copyright (c) 2015 Stephen Doyle. All rights reserved.
//

import Foundation
import CoreData

class Goal: NSManagedObject, Printable {

    @NSManaged var activity: String
    @NSManaged var targetDistance: NSNumber
    @NSManaged var distanceUnit: String
    @NSManaged var completedDistance: NSNumber

    override var description: String {
        get {
            return "Goal: \(activity) \(targetDistance)\(distanceUnit) with \(completedDistance) done"
        }
    }

    func title() -> String {
        return "\(self.activity) \(self.targetDistance) \(self.distanceUnit)"
    }
    
    func percentComplete() -> Float {
        if targetDistance == 0 {
            return 0.0
        }
        return completedDistance.floatValue / targetDistance.floatValue * 100
    }
    
    func distanceRemaining() -> Float {
        if targetDistance.floatValue <= completedDistance.floatValue {
            return 0.0
        }
        return targetDistance.floatValue - completedDistance.floatValue
    }
    
    func updateCompletedDistance(distance: Float) {
        completedDistance = completedDistance.floatValue + distance
    }
}
