//
//  ViewController.swift
//  SmileLock-Example
//
//  Created by raniys on 2/1/17.
//  Copyright © 2017 raniys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var showBlurKeyboard = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func setToShowBlurVersion(sender: UISwitch) {
        if sender.on {
            showBlurKeyboard = true
        } else {
            showBlurKeyboard = false
        }
    }
    
    @IBAction func showKeyboardTapped(sender: UIButton) {
        let keyboardID = showBlurKeyboard ? "BlurKeyboardController" : "KeyboardController"
        present(keyboardID)
    }
    
    func present(id: String) {
        
        let keyboardVC = storyboard?.instantiateViewControllerWithIdentifier(id)
        keyboardVC?.modalTransitionStyle = .CrossDissolve
        keyboardVC?.modalPresentationStyle = .OverCurrentContext
        presentViewController(keyboardVC!, animated: true, completion: nil)
    }
    
}

