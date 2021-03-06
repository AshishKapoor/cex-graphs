//
//  ViewController.swift
//  cex-graphs
//
//  Created by Ashish Kapoor on 19/06/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import UIKit
import Charts
import Alamofire

class CGMainViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    var priceStats: CGPriceStats?

    var priceStatsPriceArray = [Double]()
    var priceStatsTimeStampArray = [String]()
    
    // Mark: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currency Charts"
        
        lineChartView.delegate = self
        
        lineChartView.layerGradient()
        
        loadData()
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//    }
    
    func loadData() {
        let parameters: JSONDictionary = [priceStatsParam.lastHours.rawValue: "10", priceStatsParam.maxRespArrSize.rawValue: 6] // TODO:- Remove hardcoded values
        
        Alamofire.request(priceStatsURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil {
                    guard let responseData = response.result.value else {return}
                    guard let responseArray = responseData as? JSONArray else {return}
                    for responsePriceStats in responseArray {
                        guard let safePriceStats = responsePriceStats as? JSONDictionary else {return}
                        self.priceStats = (CGPriceStats(priceStatsData: safePriceStats))
                        
                        self.priceStatsPriceArray.append(self.priceStats?.getPriceValue ?? 0.0)
                        self.priceStatsTimeStampArray.append(self.priceStats?.getTimeStampValue ?? "")
                        self.addXValuesToBarChartView(time: self.priceStatsTimeStampArray)
                        self.setChart(dataPoints: self.priceStatsTimeStampArray, values: self.priceStatsPriceArray)
                    }
                }
                break
            case .failure(_):
                guard let error = response.result.error else {return}
                print(error)
                break
            }
        }
    }
    
    func addXValuesToBarChartView(time: [String]) {
        lineChartView.xAxis.labelCount = time.count
        lineChartView.xAxis.labelTextColor = UIColor.black
//        lineChartView.xAxis.valueFormatter = DefaultAxisValueFormatter {
//            (value, axis) -> String in return self.priceStatsTimeStampArray[Int(value)]
//        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        lineChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for points in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(points), yValues: [values[points]])
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "ETH - USD conversion")
//        chartDataSet.colors = ChartColorTemplates.colorful()
        chartDataSet.colors = [UIColor.barGraphChartColor()]
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "ETH - USD conversion")
        lineChartDataSet.colors = ChartColorTemplates.colorful()
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
}
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Entry X: \(entry.x)")
        print("Entry Y: \(entry.y)")
        print("Highlight X: \(highlight.x)")
        print("Highlight Y: \(highlight.y)")
        print("DataIndex: \(highlight.dataIndex)")
        print("DataSetIndex: \(highlight.dataSetIndex)")
        print("StackIndex: \(highlight.stackIndex)\n\n")
    }
    
    public func stringForValue(value: Double, axis: AxisBase?) -> String {
        return priceStatsTimeStampArray[Int(value)]
    }
}

