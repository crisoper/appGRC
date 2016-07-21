//
//  ClassFormatDate.swift
//  AppGRC
//
//  Created by Crisoper on 20/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import Foundation


public class String2DateFormat {
    
    class func String2DateFormatSpanish(date:String) -> String {
        
        //        let title = "The Grapes of Wrath"
        //        // Take a substring starting at an index, going to the end.
        //        let last = title.substringFromIndex(
        //            title.endIndex.advancedBy(-5))
        //        print(last)
        //
        //        // Start at the beginning, going to the specified position.
        //        let first = title.substringToIndex(
        //            title.startIndex.advancedBy(10))
        //        print(first)
        //
        //        // Get substring from a range within the string.
        //        let middle = title.substringWithRange(
        //            title.startIndex.advancedBy(4)..<title.endIndex.advancedBy(-8))
        //        print(middle)
        
        //print()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        guard let date2 = dateFormatter.dateFromString(date.substringToIndex(date.startIndex.advancedBy(10))) else {
            return date //Si no se puede formatear, devolvemos la misma fecha
        }
        
        dateFormatter.dateFormat = "dd-MM-YYYY"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date2)
        
        return timeStamp
        
        return ""
    }
    
}