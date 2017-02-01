//
//  PasswordValidator.swift
//  SmileLock-Example
//
//  Created by 廖垚雨 on 2/1/17.
//  Copyright © 2017 raniys. All rights reserved.
//

import UIKit

class PasswordModel {
    class func match(password: String) -> PasswordModel? {
        guard password == "123456" else { return nil }
        return PasswordModel()
    }
}

class PasswordValidator: PasswordUIValidation<PasswordModel> {
    init(in stackView: UIStackView, digit: Int) {
        super.init(in: stackView, digit: digit)
        self.validation = { password in
            PasswordModel.match(password)
        }
    }
    
    //handle Touch ID
    override func touchAuthenticationComplete(passwordContainerView: PasswordContainerView, success: Bool, error: NSError?) {
        if success {
            let dummyModel = PasswordModel()
            self.success?(dummyModel)
        } else {
            passwordContainerView.clearInput()
        }
    }
}

