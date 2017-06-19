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
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    var months: [String]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        barChartView.delegate = self
        
        // DataGenerator
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        addXValuesToBarChartView()
        
        setChart(dataPoints: months, values: unitsSold)
        
    }
    
    func addXValuesToBarChartView() {
        barChartView.xAxis.labelCount = months.count
        barChartView.xAxis.labelTextColor = UIColor.black
        barChartView.xAxis.valueFormatter = DefaultAxisValueFormatter {
            (value, axis) -> String in return self.months[Int(value)]
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        makePostCallToCEX()
        
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
//        chartDataSet.colors = ChartColorTemplates.liberty()

        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))

            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors

        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        
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
        
        setColorToAxis()
    }
    
    
    func makePostCallToCEX() {
    
        var request = URLRequest(url: URL(string: "https://cex.io/api/price_stats/BTC/USD")!)
        request.httpMethod = "POST"
        
        let postString = "id=13&name=Jack"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    
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
        
        return months[Int(value)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

