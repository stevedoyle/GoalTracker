//
//  AddGoalViewController.swift
//  GoalTracker
//
//  Created by Stephen Doyle on 16/01/2015.
//  Copyright (c) 2015 Stephen Doyle. All rights reserved.
//

import UIKit
import CoreData

class AddGoalViewController: UITableViewController {

    @IBOutlet weak var activityDetailLabel: UILabel!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var distanceUnitSegControl: UISegmentedControl!
    
    let managedContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var distanceUnits:[String]!
    var activity:String = "Run"
    
    @IBAction func selectedActivity(segue:UIStoryboardSegue) {
        let activityPickerViewController = segue.sourceViewController as ActivityPickerViewController
        if let selectedActivity = activityPickerViewController.selectedActivity {
            activityDetailLabel.text = selectedActivity
            activity = selectedActivity
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func createGoal() {
        let entity = NSEntityDescription.entityForName("Goal", inManagedObjectContext: managedContext!)
        let goal = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext!)
        goal.setValue(self.activityDetailLabel.text!, forKey: "activity")
        goal.setValue((distanceTextField.text as NSString).integerValue, forKey: "targetDistance")
        goal.setValue(distanceUnits[distanceUnitSegControl.selectedSegmentIndex], forKey: "distanceUnit")
        goal.setValue(0, forKey: "completedDistance")

        var error: NSError?
        if !managedContext!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        distanceUnits = ["km", "miles"]
        activityDetailLabel.text = activity

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
        if segue.identifier == "SaveGoalDetail" {
            createGoal()
        }
        
        if segue.identifier == "PickActivity" {
            let activityPickerViewController = segue.destinationViewController as ActivityPickerViewController
            activityPickerViewController.selectedActivity = activity
        }
    }
}
