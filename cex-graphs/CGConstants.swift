//
//  CGConstants.swift
//  cex-graphs
//
//  Created by Ashish Kapoor on 20/06/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import Foundation
import UIKit


// Colors

let barChartColor = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]

public typealias JSON = Any
public typealias JSONDictionary = Dictionary<String, Any>
public typealias JSONArray = Array<Any>


public enum priceStatsParam: String {
    case lastHours, maxRespArrSize
}

public enum cryptocurreny: String {
    case BTC,USD,EUR,ETH
}

// Global CEX.IO API Calls

let cexURL = "https://cex.io/api/"
let priceStats = "price_stats"
let priceStatsURL = "\(cexURL)\(priceStats)/\(cryptocurreny.BTC.rawValue)/\(cryptocurreny.USD.rawValue)"
