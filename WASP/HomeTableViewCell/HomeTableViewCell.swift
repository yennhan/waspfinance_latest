//
//  HomeTableViewCell.swift
//  WASP
//
//  Created by Leow Yenn Han on 11/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit
import Charts
class HomeTableViewCell: UITableViewCell,ChartViewDelegate {

    
    @IBOutlet weak var thePieChart: PieChartView!
    
    @IBOutlet weak var columnOne: UIView!
    
    @IBOutlet weak var theGradient: GradientView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thePieChart.delegate = self
        //makeLineChart()
        makePieChart()
        //thePieChart.layer.cornerRadius = 2.0
        //thePieChart.layer.borderWidth = 0.2
        theGradient.layer.borderWidth   = 0.2
        theGradient.layer.cornerRadius  = 5.0
        columnOne.layer.cornerRadius    = 2.0
        columnOne.layer.borderWidth     = 0.2
        //thePieChart.extraBottomOffset = 5
        //thePieChart.extraTopOffset = 5
        //thePieChart.backgroundColor = UIColor(red: 86/255, green: 189/255, blue: 126/255, alpha: 1)
        selectionStyle = .none
        
        //topBonds.isUserInteractionEnabled = false
        //topBonds.backgroundColor = UIColor(red: 69/255, green: 108/255, blue: 214/255, alpha: 1)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
extension HomeTableViewCell {
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
        thePieChart.centerAttributedText      = centerText
        thePieChart.chartDescription?.enabled = false
        thePieChart.data                      = chartData
        thePieChart.legend.enabled            = false
        //thePieChart.usePercentValuesEnabled   = true
        thePieChart.holeColor                 = UIColor.clear
        thePieChart.holeRadiusPercent         = 0.85
        
    
    }
}
extension HomeTableViewCell{
    /*func makeLineChart() {
        self.theCharts.data = setLineChartData()
        self.theCharts.legend.enabled = false
        self.theCharts.xAxis.drawGridLinesEnabled = false
        self.theCharts.xAxis.drawAxisLineEnabled = false
        self.theCharts.borderColor = UIColor.white
        //self.theCharts.xAxis.labelTextColor = UIColor.white
        //self.theCharts.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.theCharts.xAxis.drawLabelsEnabled = false
        self.theCharts.leftAxis.drawZeroLineEnabled = false
        self.theCharts.rightAxis.drawZeroLineEnabled = false
        self.theCharts.leftAxis.drawLabelsEnabled = false
        self.theCharts.rightAxis.drawLabelsEnabled = false
        self.theCharts.rightAxis.drawGridLinesEnabled = false
        self.theCharts.rightAxis.gridColor = UIColor.white
        self.theCharts.leftAxis.gridColor = UIColor.white
        self.theCharts.leftAxis.labelTextColor = UIColor.white
        self.theCharts.data?.highlightEnabled = false
        self.theCharts.doubleTapToZoomEnabled = false
        self.theCharts.pinchZoomEnabled = false
        //self.theNAME.text = "Welcome Back, \(yourName![0])"
        theLabels.text = "MYR \(theCharts.data!.getYMax())"
        
    }
    func setLineChartData() -> LineChartData  {
        let val = [ChartDataEntry(x:1,y:1),ChartDataEntry(x:2,y:10),ChartDataEntry(x:3,y:30),ChartDataEntry(x:4,y:4),ChartDataEntry(x:5,y:50),ChartDataEntry(x:6,y:6),ChartDataEntry(x:7,y:60),ChartDataEntry(x:8,y:26),ChartDataEntry(x:9,y:65),ChartDataEntry(x:10,y:99),ChartDataEntry(x:11,y:110),ChartDataEntry(x:12,y:140),ChartDataEntry(x:13,y:56),ChartDataEntry(x:14,y:150)]
        let set  = LineChartDataSet(values:val,label:"The Chart")
        
        //Gradient Building
        let gradientColors = [UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 0.5)
            , UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 1)] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        //set.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        set.fillColor = UIColor.white.withAlphaComponent(0.4)
        
        set.colors = [UIColor.white]
        //set.mode = .cubicBezier
        set.lineWidth = 2.0
        set.drawCirclesEnabled = false
        set.drawCircleHoleEnabled = false
        set.drawFilledEnabled = true
        set.fillAlpha = 0.9
        set.drawValuesEnabled = false
        set.valueColors = [UIColor.white]
        set.highlightEnabled = false
        set.highlightColor = UIColor.white
        set.highlightLineWidth = 1.5
        set.drawHorizontalHighlightIndicatorEnabled = false
        //set.setDrawHighlightIndicators(true)
        let data = LineChartData(dataSet: set)
        return data
    }

*/
}
