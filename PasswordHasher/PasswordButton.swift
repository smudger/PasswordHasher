//
//  PasswordButton.swift
//  PasswordHasher
//
//  Created by Louis Smith on 19/09/2016.
//  Copyright © 2016 Smudja. All rights reserved.
//
//  File to specify customisation options for 'copy' and 'clear' buttons.
//
//  NOT CURRENTLY USED
//

import Foundation
import UIKit

class PasswordButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // corner radius of background
        self.layer.cornerRadius = 5.0
        // colour of text
        self.tintColor = UIColor.whiteColor()
        // colour of background
        self.backgroundColor = UIColor(red: 5/255, green: 0/255, blue: 145/255, alpha: 1)
    }
}
