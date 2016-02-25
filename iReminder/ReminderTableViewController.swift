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
    var timers = [NSTimer]()

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

    // MARK: Navigation
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ReminderViewController, reminder = sourceViewController.reminder {
            
            let timeInterval = reminder.dateTime.timeIntervalSinceDate(NSDate())
            reminder.timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "timerDidEnd:", userInfo: reminder.name, repeats: false)
            timers += [reminder.timer]
            
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
    
    // MARK: Timer
    
    func timerDidEnd(timer: NSTimer) {
        let alert = UIAlertController(title: "iReminder",
            message: timer.userInfo as? String,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: {
            action in timer.invalidate()
        }))
        alert.addAction(UIAlertAction(title: "Postpone", style: UIAlertActionStyle.Default, handler: {
            action in self.postponeTimer(alert)
        }))
        
        presentViewController(alert, animated: true, completion:nil)
    }
    
    func postponeTimer(alert: UIAlertController) {
        let timeInterval = NSTimeInterval(60 * 60)
        timers += [NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "timerDidEnd:", userInfo: alert.message, repeats: false)]
    }
    
}
