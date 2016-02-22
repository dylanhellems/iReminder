//
//  ViewController.swift
//  iReminder
//
//  Created by Dylan Hellems on 2/21/16.
//  Copyright © 2016 Dylan Hellems. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: Actions
    
    @IBAction func SetDefaultLabelText(sender: UIButton) {
        nameLabel.text = "Default Text"
    }
}

