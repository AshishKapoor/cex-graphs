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
    private var _maxLotSize: Int?
    private var _minPrice: String?
    private var _maxPrice: String?
    
    init(responseData: JSONDictionary) {
        super.init()
        
        guard let symbol1 = responseData["symbol1"] as? String else {print("NULL@SYMBOL1");return}
        self._symbol1 = symbol1
        
        guard let symbol2 = responseData["symbol2"] as? String else {print("NULL@SYMBOL2");return}
        self._symbol2 = symbol2
        
        guard let minLotSize = responseData["minLotSize"] as? Double else {print("NULL@MINLOTSIZE");return}
        self._minLotSize = minLotSize
        
        guard let minLotSizeS2 = responseData["minLotSizeS2"] as? Double else {print("NULL@MINLOTSIZES2");return}
        self._minLotSizeS2 = minLotSizeS2
        
        guard let maxLotSize = responseData["maxLotSize"] as? Int else {print("NULL@MAXLOTSIZE");return}
        self._maxLotSize = maxLotSize
        
        guard let minPrice = responseData["minPrice"] as? String else {print("NULL@MINPRICE");return}
        self._minPrice = minPrice
        
        guard let maxPrice = responseData["maxPrice"] as? String else {print("NULL@MAXPRICE");return}
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
    
    var getMaxLotSize: Int {
        return _maxLotSize ?? 0
    }
    
    var getMinPrice: String {
        return _minPrice ?? ""
    }
    
    var getMaxPrice: String {
        return _maxPrice ?? ""
    }
    
}

// Consuming Currency LIMITS

//Alamofire.request(currencyLimitsURL).responseJSON { response in
//    switch(response.result) {
//    case .success(_):
//        if response.result.value != nil {
//            guard let json = response.result.value else {return}
//            for (key,value) in (json as? JSONDictionary)! {
//                if key == "data" {
//                    for (_,v) in (value as? JSONDictionary)! {
//                        guard let valueJSONArray = v as? JSONArray else {return}
//                        for j in valueJSONArray {
//                            guard let safeCurrencyLimits = j as? JSONDictionary else {return}
//                            self.currencyLimits = CGCurrencyLimits(responseData: safeCurrencyLimits)
//                            
//                            print(self.currencyLimits?.getSymbol1 ?? "~1")
//                            print(self.currencyLimits?.getSymbol2 ?? "~2")
//                            print(self.currencyLimits?.getMaxLotSize ?? "~3")
//                            print(self.currencyLimits?.getMinLotSize ?? "~4")
//                            print(self.currencyLimits?.getMinLotSizeS2 ?? "~5")
//                            print(self.currencyLimits?.getMaxPrice ?? "~6")
//                            print(self.currencyLimits?.getMinPrice ?? "~7")
//                        }
//                    }
//                }
//            }
//        }
//        break
//    case .failure(_):
//        guard let error = response.result.error else {return}
//        print(error)
//        break
//    }
//}
