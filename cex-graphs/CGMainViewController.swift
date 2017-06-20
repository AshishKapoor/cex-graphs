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
   
    @IBOutlet weak var barChartView: BarChartView!
    
    var priceStats: CGPriceStats?
    var priceStatsPriceArray = [Double]()
    var priceStatsTimeStampArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.delegate = self
        
        addXValuesToBarChartView()
        loadData()
    }
    
    func loadData() {
        
        let parameters: JSONDictionary = [
            priceStatsParam.lastHours.rawValue: "5", // TODO:- Remove hardcoded values
            priceStatsParam.maxRespArrSize.rawValue: 20 // TODO:- Remove hardcoded values
        ]
        
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
    
    func addXValuesToBarChartView() {
        barChartView.xAxis.labelCount = priceStatsTimeStampArray.count
        barChartView.xAxis.labelTextColor = UIColor.black
        barChartView.xAxis.valueFormatter = DefaultAxisValueFormatter {
            (value, axis) -> String in return self.priceStatsTimeStampArray[Int(value)]
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "ETH - USD conversion")
        chartDataSet.colors = barChartColor
//        chartDataSet.colors = ChartColorTemplates.liberty()
        
        setupBarView(chartDataSet: chartDataSet)
        
        setColorToAxis()
    }
    
    func setupBarView (chartDataSet: BarChartDataSet) -> Void {
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
        //        barChartView.chartDescription?.text = "Some relevant information with chart description."
        barChartView.chartDescription?.text = ""
        
        barChartView.xAxis.labelPosition = .bottomInside
        
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        //        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        let limitLine = ChartLimitLine(limit: 400.0, label: "Target") // TODO: - Remove hardcoded target
        barChartView.rightAxis.addLimitLine(limitLine)
    }
    
    func setColorToAxis() {
        barChartView.rightAxis.axisLineColor    = UIColor.orange
        barChartView.rightAxis.labelTextColor   = UIColor.red
        barChartView.leftAxis.labelTextColor    = UIColor.red
        barChartView.xAxis.labelTextColor       = UIColor.red
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

