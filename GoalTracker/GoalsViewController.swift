//
//  GoalsViewController.swift
//  GoalTracker
//
//  Created by Stephen Doyle on 15/01/2015.
//  Copyright (c) 2015 Stephen Doyle. All rights reserved.
//

import UIKit

class GoalsViewController: UITableViewController {

    var goals: [Goal] = [Goal(activity:"Run", targetDistance:100, distanceUnit:"km")]
    //var goals = [Goal]()
    
    @IBAction func cancelToGoalsViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveGoalDetail(segue:UIStoryboardSegue) {
        let addGoalViewController = segue.sourceViewController as AddGoalViewController
        
        // Add a new goal to the goals array
        goals.append(addGoalViewController.goal)
        
        // update the tableView
        let indexPath = NSIndexPath(forRow: goals.count-1, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        // hide the add goal view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveUpdatedGoalDetail(segue:UIStoryboardSegue) {
        let updateGoalViewController = segue.sourceViewController as UpdateGoalViewController
        
        // Goal object has been updated in the detail view
        
        // Refresh the table
        tableView.reloadData()
        
        // hide the update goal view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return goals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GoalCell", forIndexPath: indexPath) as GoalCell

        // Configure the cell...
        let goal = goals[indexPath.row] as Goal
        
        cell.titleLabel.text = goal.title()
        cell.completedLabel.text = "\(goal.completedDistance) \(goal.distanceUnit) completed"
        cell.remainingLabel.text = "\(goal.distanceRemaining()) \(goal.distanceUnit) remaining"
        cell.percentCompleteLabel.text = String(format: "%0.1f%%", arguments: [goal.percentComplete()])

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdateGoal" {
            let cell = sender as GoalCell
            let indexPath = tableView.indexPathForCell(cell)
            let selectedGoalIndex = indexPath?.row
            if let index = selectedGoalIndex {
                let selectedGoal = goals[index]

                let navController = segue.destinationViewController as UINavigationController
                let updateGoalViewController = navController.topViewController as UpdateGoalViewController
                updateGoalViewController.goalToUpdate = selectedGoal
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
