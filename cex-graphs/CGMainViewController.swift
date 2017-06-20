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
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!

    var months: [String]! // TODO: - to be removed
    var priceStats: CGPriceStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.delegate = self
        
        // Temp. DataGenerator
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"] // TODO: - months to be removed.
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0] // TODO: - setup demensions to be dynamically as per the api.
        
        addXValuesToBarChartView()
        setChart(dataPoints: months, values: unitsSold) // TODO: - months to be removed
        loadData()
    }
    
    func loadData() {
        
        let parameters: JSONDictionary = [
            priceStatsParam.lastHours.rawValue: "24",
            priceStatsParam.maxRespArrSize.rawValue: 100
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

                        // Getting Price Stats
                        print(self.priceStats?.getPriceValue ?? "")
                        print(self.priceStats?.getTimeStampValue ?? Date())
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
        barChartView.xAxis.labelCount = months.count // TODO: - months to be removed
        barChartView.xAxis.labelTextColor = UIColor.black
        barChartView.xAxis.valueFormatter = DefaultAxisValueFormatter {
            (value, axis) -> String in return self.months[Int(value)] // TODO: - months to be removed
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {      // TODO: - refactor this messy code.
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
//        chartDataSet.colors = ChartColorTemplates.liberty()
        setupBarView(chartDataSet: chartDataSet)
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        // Colorify the Pie Chart
        setupPieChartColors(dataPoints: dataPoints,dataSet: pieChartDataSet)
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        setColorToAxis()
    }
    
    func setupPieChartColors(dataPoints: [String], dataSet: PieChartDataSet) -> Void {
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))

            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }

        dataSet.colors = colors
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
        
        let limitLine = ChartLimitLine(limit: 10.0, label: "Target")
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
        return months[Int(value)] // TODO: - months to be removed
    }

}

