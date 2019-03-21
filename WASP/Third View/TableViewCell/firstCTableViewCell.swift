//
//  firstCTableViewCell.swift
//  WASP
//
//  Created by Leow Yenn Han on 22/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit
import Charts

class firstCTableViewCell: UITableViewCell,ChartViewDelegate {

    @IBOutlet weak var theGradient: GradientView!
    @IBOutlet weak var theChart: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theChart.delegate = self
       
        makePieChart()
        theGradient.layer.borderWidth   = 0.2
        theGradient.layer.cornerRadius  = 5.0
        
        selectionStyle = .none
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
extension firstCTableViewCell {
    func makePieChart() {
        let theDataEntry = [PieChartDataEntry]()
        let chartDataSet = PieChartDataSet(values: [PieChartDataEntry(value:70),PieChartDataEntry(value:30)], label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let dayString = String(describing: "RM30,000")
        let centerText = NSMutableAttributedString()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let cT1 = NSAttributedString(string: "Portfolio Value \n" , attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Avenir",size:12)!])
        let cT2 = NSAttributedString(string: dayString , attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Avenir",size:22)!])
        let cT3 = NSAttributedString(string: "\n Total" , attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Avenir",size:15)!])
        centerText.append(cT1)
        centerText.append(cT2)
        centerText.append(cT3)
        chartDataSet.colors = [UIColor.white,UIColor.white.withAlphaComponent(0.4)]
        chartDataSet.selectionShift = 0
        
        chartDataSet.drawValuesEnabled        = false
        theChart.centerAttributedText      = centerText
        theChart.chartDescription?.enabled = false
        theChart.data                      = chartData
        theChart.legend.enabled            = false
        //thePieChart.usePercentValuesEnabled   = true
        theChart.holeColor                 = UIColor.clear
        theChart.holeRadiusPercent         = 0.85
        
        
    }
}
