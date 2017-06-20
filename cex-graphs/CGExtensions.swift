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

extension UIView {
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0.0, y: 0.0)
//        layer.cornerRadius = CGFloat(frame.width / 20)
        
        let color0 = UIColor(red:250.0/255, green:250.0/255, blue:250.0/255, alpha:0.5).cgColor
        let color1 = UIColor(red:200.0/255, green:200.0/255, blue: 200.0/255, alpha:0.1).cgColor
        let color2 = UIColor(red:150.0/255, green:150.0/255, blue: 150.0/255, alpha:0.1).cgColor
        let color3 = UIColor(red:100.0/255, green:100.0/255, blue: 100.0/255, alpha:0.1).cgColor
        let color4 = UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).cgColor
        let color5 = UIColor(red:0.0/255, green:0.0/255, blue:0.0/255, alpha:0.1).cgColor
        let color6 = UIColor(red:150.0/255, green:150.0/255, blue:150.0/255, alpha:0.1).cgColor
        
        layer.colors = [color0,color1,color2,color3,color4,color5,color6]
        self.layer.insertSublayer(layer, at: 0)
    }
}
