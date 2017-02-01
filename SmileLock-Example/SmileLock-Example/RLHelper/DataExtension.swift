//
//  DataExtension.swift
//  QBCloud
//
//  Created by gaoshanyu on 8/25/16.
//  Copyright © 2016 raniys. All rights reserved.
//

import Foundation

public extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}

public extension Int {
    
    public var kb : Float { return Float(self) / 1_024 }
    public var mb : Float { return Float(self) / 1_024 / 1_024 }
    public var gb : Float { return Float(self) / 1_024 / 1_024 / 1_024 }
    
}


public extension Double {
    
    public var F: Double { return self } // 华氏温度
    public var C: Double { return (((self - 32.0) * 5.0) / 9.0) } // 摄氏温度
    public var K: Double { return (((self - 32.0) / 1.8) + 273.15) } // 开氏温度
    
}

public extension String {
    
    /// Trim white space and Newline character for string
    public var trim : String { return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) }
    
    /// Regex match
    ///
    /// - parameter strRegex: the regex in string
    func matches(regex: String) -> Bool {
        
        let regex = try! NSRegularExpression(pattern: regex, options: .DotMatchesLineSeparators)
        
        return regex.numberOfMatchesInString(self, options: .ReportCompletion, range: NSMakeRange(0, self.characters.count-1)) > 0 ? true : false
        
    }
    
    /// Catch a string
    ///
    /// - parameter str: catch string start at
    /// - parameter include: whether to include the start string
    func subFrom(str: String, include: Bool) -> String {
        
        if str == "" {
            return self
        }
        
        let range = self.rangeOfString(str)!
        
        return include ? self.substringFromIndex(range.startIndex) : self.substringFromIndex(range.endIndex)
    }
    
    /// Catch a string
    ///
    /// - parameter str: catch string end at
    /// - parameter include: whether to include the end string
    func subTo(str: String, include: Bool) -> String {
        
        if str == "" {
            return self
        }
        
        let range = self.rangeOfString(str)!
        
        return include ? self.substringToIndex(range.endIndex) : self.substringToIndex(range.startIndex)
    }
}

public extension NSDate {
   
    func year() -> Int {
        return NSCalendar.currentCalendar().component(.Year, fromDate: self)
    }
    
    func month() -> Int {
        return NSCalendar.currentCalendar().component(.Month, fromDate: self)
    }
    
    func day() -> Int {
        return NSCalendar.currentCalendar().component(.Day, fromDate: self)
    }
    
    func hour() -> Int {
        return NSCalendar.currentCalendar().component(.Hour, fromDate: self)
    }
    
    func minute() -> Int {
        return NSCalendar.currentCalendar().component(.Minute, fromDate: self)
    }
    
    func second() -> Int {
        return NSCalendar.currentCalendar().component(.Second, fromDate: self)
    }
    
    /// 1: Sunday ... 7: Saturday
    func weekday() -> Int {
        return NSCalendar.currentCalendar().component(.Weekday, fromDate: self)
    }
    
    /// Format date to string: yyyy-MM-dd
    func stringDate() -> String {
        
        var strDate = self.description
        
        var dateFormatter: NSDateFormatter?
        
        if dateFormatter == nil {
            
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd"
            dateFormatter?.locale = NSLocale.currentLocale()
            
        }
        
        strDate = dateFormatter!.stringFromDate(self)
        
        return strDate
    }
    
    /// Format date to string: HH:mm
    func stringMinute() -> String {
        
        var stringMinute = self.description
        
        var dateFormatter: NSDateFormatter?
        
        if dateFormatter == nil {
            
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "HH:mm"
            dateFormatter?.locale = NSLocale.currentLocale()
            
        }
        
        stringMinute = dateFormatter!.stringFromDate(self)
        
        return stringMinute
    }
    
    /// Format date to string: yyyy-MM-dd HH:mm
    func stringMinuteDate() -> String {
        
        var strDate = self.description
        
        var dateFormatter: NSDateFormatter?
        
        if dateFormatter == nil {
            
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd HH:mm"
            dateFormatter?.locale = NSLocale.currentLocale()
            
        }
        
        strDate = dateFormatter!.stringFromDate(self)
        
        return strDate
    }
    
    /// Format date to string: yyyy-MM-dd HH:mm:ss
    func stringSecondDate() -> String {
        
        var strDate = self.description
        
        var dateFormatter: NSDateFormatter?
        
        if dateFormatter == nil {
            
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter?.locale = NSLocale.currentLocale()
            
        }
        
        strDate = dateFormatter!.stringFromDate(self)
        
        return strDate
    }
    
    /// Format date to string: yyyy-MM-dd HHmmss
    func nameSecondDate() -> String {
        
        var strDate = self.description
        
        var dateFormatter: NSDateFormatter?
        
        if dateFormatter == nil {
            
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = "yyyy-MM-dd HHmmss"
            dateFormatter?.locale = NSLocale.currentLocale()
            
        }
        
        strDate = dateFormatter!.stringFromDate(self)
        
        return strDate
    }
    
    /// Format date to string as format
    func stringDateByStringFormat(format: String) -> String {
        
        var strDate = self.description
        
        var dateFormatter: NSDateFormatter?
        
        if dateFormatter == nil {
            
            dateFormatter = NSDateFormatter()
            dateFormatter?.dateFormat = format
            dateFormatter?.locale = NSLocale.currentLocale()
            
        }
        
        strDate = dateFormatter!.stringFromDate(self)
        
        return strDate
    }
}
