//
//  ViewController.swift
//  PasswordHasher
//
//  Created by Louis Smith on 15/09/2016.
//  Copyright © 2016 Smudja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Label to send password to
    @IBOutlet weak var pwdLabel: UILabel!
    
    // input text field for string to be hashed
    @IBOutlet weak var textInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*  onButtonPress
     *
     *  - function called when button is pressed using
     *  'touch up inside' event
     */
    @IBAction func onButtonPress(sender: UIButton) {
        // remove first responder status for text field (closes software keyboard)
        self.textInputField.resignFirstResponder()
        
        let title = sender.titleForState(.Normal)!
        
        if textInputField.hasText() {
            let pwd = textInputField.text
            
            pwdLabel.text = pwd
        }
        else {
            pwdLabel.text = "\(title)ed"
        }
    }
    
    /* touchesBegan
     *
     * - function called when user touches the screen
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // end editing of current view (closes software keyboard)
        self.view.endEditing(true)
    }

}

