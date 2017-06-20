//
//  CGPriceStats.swift
//  cex-graphs
//
//  Created by Ashish Kapoor on 20/06/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation

class CGPriceStats: NSObject {
    
    private var _timeStamp: Date?
    private var _price: String?
    
    init(priceStatsData: JSONDictionary) {
        super.init()
        
        guard let parsedPrice = priceStatsData["price"] as? String else {return}
        self._price     = parsedPrice
        
        guard let parsedTimeStamp = priceStatsData["tmsp"] as? TimeInterval else {return}
        // Converting UNIX Time Interval to Date format
        let date = Date(timeIntervalSince1970: parsedTimeStamp)
        self._timeStamp = date
    }
    
    var getTimeStampValue: String {
        guard let timeStamp = self._timeStamp else { return "" }
        return Date.unixTimestampToString(timeStamp: timeStamp)
    }
    
    var getPriceValue: Double {
        guard let price = self._price else { return 0.0 }
        return Double.stringToDouble(stringValue: price)
    }
}
