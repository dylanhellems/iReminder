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

        // Load samplee data
        loadSampleReminders()
    }
    
    func loadSampleReminders() {
        let photo1 = UIImage(named: "defaultImage")!
        let reminder1 = Reminder(name: "Caprese Salad", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "emptyStar")!
        let reminder2 = Reminder(name: "Chicken and Potatoes", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "filledStar")!
        let reminder3 = Reminder(name: "Pasta with Meatballs", photo: photo3, rating: 3)!
        
        reminders += [reminder1, reminder2, reminder3]
    }

    // MARK: - Table view data source

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
        cell.photoImageView.image = reminder.photo
        cell.ratingControl.rating = reminder.rating

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: Navigation
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? ReminderViewController, reminder = sourceViewController.reminder {
            
            // Add a new reminder
            let newIndexPath = NSIndexPath(forRow: reminders.count, inSection: 0)
            reminders.append(reminder)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
