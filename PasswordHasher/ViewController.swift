//
//  ViewController.swift
//  PasswordHasher
//
//  Created by Louis Smith on 15/09/2016.
//  Copyright © 2016 Smudja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // length of password to create
    let PWD_LENGTH = 12

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
        
        if textInputField.hasText() {
            // hash text in text field using sha512 function
            let hashedString = sha512(textInputField.text!)
            
            // specify range of hashedString to select for password
            let pwdRange = hashedString.startIndex..<hashedString.startIndex.advancedBy(PWD_LENGTH)
            
            // create password from hashedString using previous range
            let password = hashedString.substringWithRange(pwdRange)
            
            //set label to password
            pwdLabel.text = "\(password)"
        }
        else {
            pwdLabel.text = "No Text To Hash :("
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
    
    /* sha512
     *
     * - takes a string input and returns the hash of that string using SHA512 as a string
     */
    func sha512(inputText: String) -> String {
        // create an array of type UInt8 that has length CC_SHA512_DIGEST_LENGTH and is populated with '0'
        var digest = [UInt8](count: Int(CC_SHA512_DIGEST_LENGTH), repeatedValue: 0)
        
        // convert string to NSData using UTF8 encoding if possible
        if let data = inputText.dataUsingEncoding(NSUTF8StringEncoding) {
            //hash data given as bytes of length data.length and save to digest. '&' passes digest by reference not by value so the function actually edits the digest variable
            CC_SHA512(data.bytes, CC_LONG(data.length), &digest)
        }
        
        // variable to store digest in hexadecimal
        var digestHex = ""
        
        // iterate over digest
        for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
            // format into hexadecimal and add to digestHex
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }

}

