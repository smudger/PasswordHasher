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
    let PWD_LENGTH = 10

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
    
    /* onCopyCall
     * 
     * - function called when 'copy' button is pressed using
     *   'touch up inside' event
     * - copies contents of pwdLabel to clipboard to be used in other apps
     */
    @IBAction func onCopyCall(sender: UIButton) {
        
    }
    
    /* onClearCall
     *
     * - function called when 'clear' button is pressed using
     *   'touch up inside' event
     * - clears contents of pwdLabel
     */
    @IBAction func onClearCall(sender: UIButton) {
        pwdLabel.text = "Cleared"
    }
    
    /*  onHashCall
     *
     *  - function called when 'hash' button is pressed using
     *  'touch up inside' event
     */
    @IBAction func onHashCall(sender: UIButton) {
        // remove first responder status for text field (closes software keyboard)
        self.textInputField.resignFirstResponder()
        
        if textInputField.hasText() {
            // hash text in text field using sha512 function
            let hashedString = sha512(textInputField.text!)
            
            // specify range of hashedString to select for password
            let pwdRange = hashedString.endIndex.advancedBy(-PWD_LENGTH)..<hashedString.endIndex
            
            // create password from hashedString using previous range
            var password = hashedString.substringWithRange(pwdRange)
            
            // ensure password contains at least one number char (0-9)
            if !containsNumeric(password) {
                var pwdCharArray = Array(password.characters)
                pwdCharArray[2] = "3"
                password = String(pwdCharArray)
            }
            
            // test if password contains to alpha (a-z) characters
            if containsTwoAlpha(password) {
                // make even alpha chars upper-case
                pwdLabel.text = evenToUpper(password)
            // if not we will add one upper and one lower case character
            } else {
                var pwdCharArray = Array(password.characters)
                pwdCharArray[0] = "d"
                pwdCharArray[1] = "C"
                pwdLabel.text = String(pwdCharArray)
            }
        }
        // clear contents of text field
        textInputField.text = ""
    }
    
    /* touchesBegan
     *
     * - function called when user touches the screen
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // end editing of current view (closes software keyboard)
        self.view.endEditing(true)
    }
    
    /* containsNumeric
     *
     * - function to test if a string contains a numeric (0-9) character
     */
    func containsNumeric(testString: String) -> Bool {
        // set containing all lower-case letters
        let numChar = NSCharacterSet.decimalDigitCharacterSet()        // letter counter
        
        // iterate over characters in testString
        for char in testString.unicodeScalars {
            // if character is a lower-case alpha character return true
            if numChar.longCharacterIsMember(char.value) {
                return true
            }
        }
        
        return false
    }
    
    /* containsTwoAlpha
     * 
     * - function to test if a string contains two or more lower-case alpha character (a-z)
     */
    func containsTwoAlpha(testString: String) -> Bool {
        // set containing all lower-case letters
        let alphaChar = NSCharacterSet.lowercaseLetterCharacterSet()
        // letter counter
        var letterCount = 0

        // iterate over characters in testString
        for char in testString.unicodeScalars {
            // if character is a lower-case alpha character increment counter
            if alphaChar.longCharacterIsMember(char.value) {
                letterCount += 1
            }
        }
        
        if letterCount >= 2 {
            return true
        }
        else {
            return false
        }
    }
    
    /* evenToUpper
     *
     * - function to make every other alpha character in a string upper-case
     * - starts with second alpha character
     */
    func evenToUpper(lowerString: String) -> String {
        // set containing all lower-case letters
        let alphaChar = NSCharacterSet.lowercaseLetterCharacterSet()
        // lower-case letter counter
        var letterCount = 0
        // set upperString to be lowerString
        var upperString = lowerString
        
        // counter to record index of current char
        var counter = 0
        // iterate over chars in upperString
        for char in upperString.unicodeScalars {
            // if we have a alpha char
            if alphaChar.longCharacterIsMember(char.value) {
                // and we are on an even alpha char
                if (letterCount % 2) == 1 {
                    // get char array of upperString
                    var charArray = Array(upperString.characters)
                    // and make the current char upper-case
                    charArray[counter] = Array(String(char).uppercaseString.characters)[0]
                    // set upper string to this new char array
                    upperString = String(charArray)
                }
                letterCount += 1
            }
            counter += 1
        }
        return upperString
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

