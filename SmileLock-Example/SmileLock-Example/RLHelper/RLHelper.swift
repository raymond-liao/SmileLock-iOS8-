//
//  RLHelper.swift
//  QBCloud
//
//  Created by gaoshanyu on 9/2/16.
//  Copyright © 2016 raniys. All rights reserved.
//

import Foundation
import UIKit

public class RLHelper: NSObject {
    
    /// Convert NSObject array to String array. i.e.: [1,2,3]->['1','2','3']
    class func bridgeObjToStringArray(array: [NSObject]) -> [String?] {
        var newArray = [String?]()
        for object in array
        {
            newArray.append(object as? String)
        }
        return newArray
    }
    
}
