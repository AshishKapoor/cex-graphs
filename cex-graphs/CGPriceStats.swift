//
//  CGPriceStats.swift
//  cex-graphs
//
//  Created by Ashish Kapoor on 20/06/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation
import SwiftyJSON

class CGPriceStats: NSObject {
    
    private var _timeStamp: Date?
    private var _price: String?
    
    init(priceStatsData: JSONDictionary) {
        super.init()
        
        guard let parsedPrice = priceStatsData["price"] as? String else {print("Issue at parsedPrice");return}
        self._price     = parsedPrice
        
        guard let parsedTimeStamp = priceStatsData["tmsp"] as? TimeInterval else {print("Issue at parsedTimeStamp"); return}
        let date = Date(timeIntervalSince1970: parsedTimeStamp) // Converting UNIX Time Interval to Date format
        self._timeStamp = date
    }
    
    var getTimeStampValue: Date {
        set {
            // Todo: - convert date with required format
        } get {
            guard let timeStamp = self._timeStamp else { return Date() }
            return timeStamp
        }
    }
    
    var getPriceValue: String {
        set {
            // Todo: - convert price with required currency logo
        } get {
            guard let price = self._price else { return "" }
            return price
        }
    }
}
