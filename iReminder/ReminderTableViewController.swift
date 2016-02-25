//
//  ReminderTableViewController.swift
//  iReminder
//
//  Created by Dylan Hellems on 2/22/16.
//

import UIKit

class ReminderTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var reminders = [Reminder]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ReminderTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReminderTableViewCell

        let reminder = reminders[indexPath.row]
        
        cell.nameLabel.text = reminder.name
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        
        cell.dateTimeLabel.text = dateFormatter.stringFromDate(reminder.dateTime)

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            reminders.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: Navigation
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ReminderViewController, reminder = sourceViewController.reminder {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing reminder
                reminders[selectedIndexPath.row] = reminder
                reminders.sortInPlace({ $0.dateTime.compare($1.dateTime) == .OrderedAscending })
                let updatedIndexPath = NSIndexPath(forRow: reminders.indexOf( {$0 === reminder} )!, inSection: 0)
                tableView.reloadRowsAtIndexPaths([updatedIndexPath], withRowAnimation: .None)
            } else {
            
                // Add a new reminder
                reminders.append(reminder)
                reminders.sortInPlace({ $0.dateTime.compare($1.dateTime) == .OrderedAscending })
                let newIndexPath = NSIndexPath(forRow: reminders.indexOf( {$0 === reminder} )!, inSection: 0)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let reminderDetailViewController = segue.destinationViewController as! ReminderViewController
            
            // Get the cell that generated this segue.
            if let selectedReminderCell = sender as? ReminderTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedReminderCell)!
                let selectedReminder = reminders[indexPath.row]
                reminderDetailViewController.reminder = selectedReminder
            }
            
        }
    }
    
}
