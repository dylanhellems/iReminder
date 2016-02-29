//
//  ReminderViewController.swift
//  iReminder
//
//  Created by Dylan Hellems on 2/21/16.
//

import UIKit

class ReminderViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
    This value is either passed by `ReminderTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new reminder.
    */
    var reminder: Reminder?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks
        nameTextField.delegate = self
        
        // Handle the text views’s user input through delegate callbacks
        descriptionTextField.delegate = self
        
        // Set up views if editing an existing Reminder
        if let reminder = reminder {
            navigationItem.title = reminder.name
            nameTextField.text   = reminder.name
            descriptionTextField.text = reminder.description
            datePicker.date = reminder.dateTime
        }
        
        // Set date picker's minimum date to current date
        datePicker.minimumDate = NSDate().dateByAddingTimeInterval(NSTimeInterval(60))
        
        // Enable the Save button only if the text field has a valid reminder name
        checkValidReminderName()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        // Disable the Save button while editing name
        if textField === nameTextField {
            saveButton.enabled = false
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidReminderName()
        navigationItem.title = textField.text
    }
    
    func checkValidReminderName() {
        
        // Disable the Save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let description = descriptionTextField.text ?? ""
            
            let timeInterval = floor(datePicker.date.timeIntervalSinceReferenceDate / 60.0) * 60.0
            let dateTime = NSDate(timeIntervalSinceReferenceDate: timeInterval)
            
            // Set the reminder to be passed to ReminderTableViewController after the unwind segue.
            reminder = Reminder(name: name, dateTime: dateTime, description: description)
        }
        
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
}

