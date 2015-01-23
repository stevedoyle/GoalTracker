//
//  UpdateGoalViewController.swift
//  GoalTracker
//
//  Created by Stephen Doyle on 16/01/2015.
//  Copyright (c) 2015 Stephen Doyle. All rights reserved.
//

import UIKit

class UpdateGoalViewController: UITableViewController {

    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var distanceCompletedLabel: UILabel!
    @IBOutlet weak var distanceRemainingLabel: UILabel!
 
    let managedContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    var goalToUpdate: Goal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let goal = goalToUpdate {
            goalTitleLabel.text = goal.title()
            distanceCompletedLabel.text = "\(goal.completedDistance) \(goal.distanceUnit) completed"
            distanceRemainingLabel.text = "\(goal.distanceRemaining()) \(goal.distanceUnit) remaining"
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveUpdatedGoalDetail" {
            goalToUpdate.updateCompletedDistance((distanceTextField.text as NSString).floatValue)
            managedContext?.save(nil)
        }
    }
}
