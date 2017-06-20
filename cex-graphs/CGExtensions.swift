//
//  CGExtensions.swift
//  cex-graphs
//
//  Created by Ashish Kapoor on 20/06/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func barGraphChartColor() -> UIColor {
        return UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)
    }
    
    class func barGraphBackColor() -> UIColor {
        return UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
    }
}

extension Date {
    static func unixTimestampToString(timeStamp: Date) -> String {
        return DateFormatter.localizedString(from: timeStamp as Date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
    }
}

extension Double {
    static func stringToDouble(stringValue: String) -> Double {
        return (stringValue as NSString).doubleValue
    }
}
