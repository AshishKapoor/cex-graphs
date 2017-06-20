//
//  CGCurrencyLimitsTVC.swift
//  cex-graphs
//
//  Created by Ashish Kapoor on 20/06/17.
//  Copyright © 2017 Ashish Kapoor. All rights reserved.
//

import UIKit
import Alamofire

class CGCurrencyLimitsTVC: UITableViewController {
   
    var currencyLimits: CGCurrencyLimits?
    
    var symbolArr: [String] = []
    
    var lotSizeArr: [String] = []
    
    var minLotSizeS2Arr: [String] = []
    
    var pricePriceArr: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Currency Limit"
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
        view.layerGradient()
        
        tableView.tableFooterView = UIView()
        
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
        // Consuming Currency LIMITS
        Alamofire.request(currencyLimitsURL).responseJSON { response in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil {
                    guard let json = response.result.value else {return}
                    for (key,value) in (json as? JSONDictionary)! {
                        if key == "data" {
                            for (_,v) in (value as? JSONDictionary)! {
                                guard let valueJSONArray = v as? JSONArray else {return}
                                for pairs in valueJSONArray {
                                    guard let safeCurrencyLimits = pairs as? JSONDictionary else {return}
                                    self.currencyLimits = CGCurrencyLimits(responseData: safeCurrencyLimits)
                                    
                                    self.symbolArr.append("\(self.currencyLimits?.getSymbol1 ?? "")/\(self.currencyLimits?.getSymbol2 ?? "")")
                                    
                                    self.lotSizeArr.append("Pending: \(self.currencyLimits?.getMinLotSize ?? 0.0)/\(self.currencyLimits?.getMaxLotSize ?? 0.0)")
//                                    self.lotSizeArr.append("\(self.currencyLimits?.getMinLotSizeS2 ?? 0.0)") // Unused
                                    self.pricePriceArr.append("\(self.currencyLimits?.getMinPrice ?? "")/\(self.currencyLimits?.getMaxPrice ?? "")\n\n")
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
                break
            case .failure(_):
                guard let error = response.result.error else {return}
                print(error)
                break
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.symbolArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CGCurrencyLimitsCell", for: indexPath)
        // Configure the cell...
        
        cell.textLabel?.text        = self.symbolArr[indexPath.row]
        cell.detailTextLabel?.text  = self.lotSizeArr[indexPath.row]
        
        return cell
    }

}
