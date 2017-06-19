//
//  ViewController.swift
//  cex-graphs
//
//  Created by Ashish Kapoor on 19/06/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import UIKit
import Charts

class CGMainViewController: UIViewController, ChartViewDelegate {
   
    @IBOutlet weak var barChartView: BarChartView!
    var months: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        barChartView.delegate = self
        
        
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        addXValues ()
        
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(dataPoints: months, values: unitsSold)
        
    }
    
    func addXValues() {
        barChartView.xAxis.labelCount = months.count
        barChartView.xAxis.valueFormatter = DefaultAxisValueFormatter {
            (value, axis) -> String in return self.months[Int(value)]
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)

        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)        
        
        barChartView.data = chartData
        
        barChartView.chartDescription?.text = "Some relevant info"
        
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        barChartView.xAxis.labelPosition = .bottom
        
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
        let limitLine = ChartLimitLine(limit: 10.0, label: "Target")
        
        barChartView.rightAxis.addLimitLine(limitLine)
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("\(entry) in \(chartView) and highlight at \(highlight)")
    }
    
    public func stringForValue(value: Double, axis: AxisBase?) -> String {
        
        return months[Int(value)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

