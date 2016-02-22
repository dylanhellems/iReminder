//
//  ViewController.swift
//  iReminder
//
//  Created by Dylan Hellems on 2/21/16.
//  Copyright © 2016 Dylan Hellems. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        nameLabel.text = nameTextField.text
    }
    
    // MARK: Actions
    
    @IBAction func SetDefaultLabelText(sender: UIButton) {
        nameLabel.text = "Default Text"
    }
}

