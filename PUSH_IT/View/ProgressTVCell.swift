//
//  ProgressTVCell.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/26/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import UIKit
import Charts

protocol ProgressTVCellDataSource: class {
    func loadData(forExercise exercise: String) -> [String: Int]
}

class ProgressTVCell: UITableViewCell {
 
    // outlets
    @IBOutlet weak var exerciseNameLbl: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var chart: LineChartView!
    
    // variables
    var chartData = [String: Int]()
    var chartDataEntry = [ChartDataEntry]()
    var exerciseName : String?
    var dataSource: ProgressTVCellDataSource?
    
    // lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData() {
        
        chartData = (self.dataSource?.loadData(forExercise: exerciseName!))!
        
        chartData.forEach { (item) in
            let (key, value) = item
            // have key as date in string format "mm/dd/YYYY"
            let date = DateFormatter.shortStringDateFormatter.date(from: key)
            // need a number value for x axis
            if date == nil {return}
            
            let numDateString = DateFormatter.numberDateFormatter.string(from: date!)
            
            let numDate = Double(numDateString)
            if numDate == nil {
                debugPrint("Something went wrong with date conversion")
                return
            }
            let doubleValue = Double(value)

            let chartDataPoint = ChartDataEntry(x: numDate!, y: doubleValue)
            chartDataEntry.append(chartDataPoint)
        }
        let line = LineChartDataSet(values: chartDataEntry, label: "progress")
        
        line.colors = [NSUIColor.red]
        
        let data = LineChartData()
        data.addDataSet(line)
        
        chart.data = data
        
        chart.drawGridBackgroundEnabled = false
        chart.notifyDataSetChanged()
    }
    
}
