//
//  ViewController.swift
//  PasswordHasher
//
//  Created by Louis Smith on 15/09/2016.
//  Copyright © 2016 Smudja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hashStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onButtonPress(sender: UIButton) {
        let title = sender.titleForState(.Normal)!
        
        hashStatusLabel.text = "\(title)ed"
        
    }

}

