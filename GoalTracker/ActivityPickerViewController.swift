//
//  ActivityPickerViewController.swift
//  GoalTracker
//
//  Created by Stephen Doyle on 16/01/2015.
//  Copyright (c) 2015 Stephen Doyle. All rights reserved.
//

import UIKit

class ActivityPickerViewController: UITableViewController {
    
    var activities:[String]!
    var selectedActivity:String? = nil
    var selectedActivityIndex:Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activities = ["Run", "Cycle", "Walk", "Swim"]
        
        if let activity = selectedActivity {
            selectedActivityIndex = find(activities, activity)!
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return activities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = activities[indexPath.row]

        if indexPath.row == selectedActivityIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Other row is selected - need to deselect it
        if let index = selectedActivityIndex {
            let cell =  tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        selectedActivityIndex = indexPath.row
        selectedActivity = activities[indexPath.row]
        
        // update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedActivity" {
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            selectedActivityIndex = indexPath?.row
            if let index = selectedActivityIndex {
                selectedActivity = activities[index]
            }
        }
    }
}
