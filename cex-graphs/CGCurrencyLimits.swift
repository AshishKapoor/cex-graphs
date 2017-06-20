//
//  CGCurrencyLimits.swift
//  cex-graphs
//
//  Created by Ashish Kapoor on 20/06/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation

class CGCurrencyLimits: NSObject {
    
    private var _symbol1: String?
    private var _symbol2: String?
    private var _minLotSize: Double?
    private var _minLotSizeS2: Double?
    private var _maxLotSize: Double?
    private var _minPrice: String?
    private var _maxPrice: String?
    
    init(responseData: JSONDictionary) {
        super.init()
        
        guard let symbol1 = responseData["symbol1"] as? String else {return}
        self._symbol1 = symbol1
        
        guard let symbol2 = responseData["symbol2"] as? String else {return}
        self._symbol2 = symbol2
        
        guard let minLotSize = responseData["minLotSize"] as? Double else {return}
        self._minLotSize = minLotSize
        
        guard let minLotSizeS2 = responseData["minLotSizeS2"] as? Double else {return}
        self._minLotSizeS2 = minLotSizeS2
        
        guard let maxLotSize = responseData["maxLotSize"] as? Double else {return}
        self._maxLotSize = maxLotSize
        
        guard let minPrice = responseData["minPrice"] as? String else {return}
        self._minPrice = minPrice
        
        guard let maxPrice = responseData["maxPrice"] as? String else {return}
        self._maxPrice = maxPrice
    }
    
    var getSymbol1: String {
     return _symbol1 ?? ""
    }
    
    var getSymbol2: String {
     return _symbol2 ?? ""
    }
    
    var getMinLotSize: Double {
        return _minLotSize ?? 0.0
    }
    
    var getMinLotSizeS2: Double {
        return _minLotSizeS2 ?? 0.0
    }
    
    var getMaxLotSize: Double {
        return _maxLotSize ?? 0
    }
    
    var getMinPrice: String {
        return _minPrice ?? ""
    }
    
    var getMaxPrice: String {
        return _maxPrice ?? ""
    }
    
}
