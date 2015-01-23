//
//  GoalsViewController.swift
//  GoalTracker
//
//  Created by Stephen Doyle on 15/01/2015.
//  Copyright (c) 2015 Stephen Doyle. All rights reserved.
//

import UIKit
import CoreData

class GoalsViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let managedContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    @IBAction func cancelToGoalsViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveGoalDetail(segue:UIStoryboardSegue) {
        // hide the add goal view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveUpdatedGoalDetail(segue:UIStoryboardSegue) {
        // Goal object has been updated in the detail view
        
        // Refresh the table
        tableView.reloadData()
        
        // hide the update goal view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: goalFetchRequest(), managedObjectContext: managedContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    func goalFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Goal")
        let sortDescriptor = NSSortDescriptor(key: "targetDistance", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    func numberOfGoals() -> Int {
        return fetchedResultsController.sections![0].numberOfObjects
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return fetchedResultsController.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return fetchedResultsController.sections![section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let goal = fetchedResultsController.objectAtIndexPath(indexPath) as Goal

        // Configure the cell...
        
        let cell = tableView.dequeueReusableCellWithIdentifier("GoalCell", forIndexPath: indexPath) as GoalCell
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
            let selectedGoal = fetchedResultsController.objectAtIndexPath(indexPath!) as Goal
            let navController = segue.destinationViewController as UINavigationController
            let updateGoalViewController = navController.topViewController as UpdateGoalViewController
            updateGoalViewController.goalToUpdate = selectedGoal
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let managedObject:NSManagedObject = fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
            managedContext?.deleteObject(managedObject)
            managedContext?.save(nil)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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
