//
//  ProductPanels.swift
//  WASP
//
//  Created by Leow Yenn Han on 13/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit
import Charts
class ProductPanels: UIViewController,ChartViewDelegate {
    //lazy var panelManager = Panels(target:self)
    
   
    @IBOutlet weak var theChart: MyLineChartView!
    
    @IBOutlet weak var backgroundColor: UIView!
    
    @IBOutlet weak var alltheTimeButtonStack: UIStackView!
    @IBOutlet weak var theLabels: UILabel!
    
    @IBOutlet weak var thePeriodSchedule: UIView!
    
    let lineChartView = MyLineChartView()
    
    @IBOutlet weak var pCV: UICollectionView!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        backgroundColor.layer.backgroundColor = UIColor(red: 58/255, green: 151/255, blue: 227/255, alpha: 1).cgColor
        backgroundColor.layer.cornerRadius = 4.0

        theChart.delegate = self
        theChart.myChartViewDelegate = self as MyChartViewDelegate // delegate with our additions (knowing when a value is no longer selected)
        theChart.highlightPerTapEnabled = false // disable tap gesture to highlight
        theChart.highlightPerDragEnabled = false // disable pan gesture
        pCV.dataSource = self
        pCV.delegate   = self
        theLabels.isHidden = true
        makeLineChart()
        pCV.flashScrollIndicators()
       
    }
    func makeRounded(theImage: UIImageView) {
        theImage.layer.borderWidth = 1
        theImage.layer.masksToBounds = false
        theImage.layer.borderColor = UIColor.black.cgColor
        theImage.layer.cornerRadius = theImage.frame.height/2
        theImage.clipsToBounds = true
    }
    @IBAction func buyItem(_ sender: Any) {
       // self.present
    }
    
    @IBAction func sellProduct(_ sender: Any) {
    }
    
}
extension ProductPanels: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pOneCell", for: indexPath) as! pOneCollectionViewCell
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
            return cell
        } else if indexPath.row == 1 {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "pTwoCell", for: indexPath) as! pTwoCollectionViewCell
            cell2.layer.borderColor = UIColor.lightGray.cgColor
            cell2.layer.borderWidth = 0.5
            return cell2
        }else {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "pThreeCell", for: indexPath) as! pThreeCollectionViewCell
            cell3.layer.borderColor = UIColor.lightGray.cgColor
            cell3.layer.borderWidth = 0.5
            return cell3
        }
    }
}

extension ProductPanels{
    func makeLineChart() {
        self.theChart.data = setLineChartData()
        self.theChart.minOffset = 0
        self.theChart.drawBordersEnabled = false
        self.theChart.legend.enabled = false
        self.theChart.xAxis.drawGridLinesEnabled = false
        self.theChart.xAxis.drawAxisLineEnabled = false
        self.theChart.xAxis.drawLabelsEnabled = false
        self.theChart.leftAxis.drawLabelsEnabled = false
        self.theChart.rightAxis.drawLabelsEnabled = false
        self.theChart.rightAxis.drawGridLinesEnabled = true
        self.theChart.rightAxis.gridColor = UIColor.white
        self.theChart.leftAxis.gridColor = UIColor.white
        self.theChart.leftAxis.drawGridLinesEnabled = false
        self.theChart.leftAxis.labelTextColor = UIColor.white
        self.theChart.data?.highlightEnabled = true
        self.theChart.doubleTapToZoomEnabled = false
        self.theChart.pinchZoomEnabled = false
        
    }
    func setLineChartData() -> LineChartData  {
        let val = [ChartDataEntry(x:1,y:1),ChartDataEntry(x:2,y:10),ChartDataEntry(x:3,y:30),ChartDataEntry(x:4,y:4),ChartDataEntry(x:5,y:50),ChartDataEntry(x:6,y:6),ChartDataEntry(x:7,y:60),ChartDataEntry(x:8,y:26),ChartDataEntry(x:9,y:65),ChartDataEntry(x:10,y:99),ChartDataEntry(x:11,y:110),ChartDataEntry(x:12,y:140),ChartDataEntry(x:13,y:56),ChartDataEntry(x:14,y:150)]
        let set  = LineChartDataSet(values:val,label:"The Chart")
        set.fillColor = UIColor.white.withAlphaComponent(0.5)
        
        set.colors = [UIColor.white]
        set.lineWidth = 2.0
        set.drawCirclesEnabled = false
        set.drawCircleHoleEnabled = false
        set.drawFilledEnabled = true
        set.fillAlpha = 0.9
        set.drawValuesEnabled = false
        set.valueColors = [UIColor.black]
        set.highlightEnabled = true
        set.highlightColor = UIColor.white
        set.highlightLineWidth = 1.5
        set.drawHorizontalHighlightIndicatorEnabled = false
        //set.setDrawHighlightIndicators(true)
        let data = LineChartData(dataSet: set)
        return data
        
    }
}


extension ProductPanels {
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        //let graphPoint = chartView.getMarkerPosition(highlight: highlight)
        thePeriodSchedule.isHidden = true
        theLabels.isHidden = false
        theLabels.translatesAutoresizingMaskIntoConstraints = true
        
        //theLabels.center.x = highlight.xPx
        theLabels!.frame.origin.x = highlight.xPx
        theLabels.text = "\(entry.y)"
        theLabels.textColor = UIColor.white

            //theLabels.isHidden = false
        theLabels.fadeIn()
        thePeriodSchedule.fadeOut()
        
        //self.testCollection.isScrollEnabled = false
        //var set1 = LineChartDataSet()
        //set1 = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        //chartView.data?.notifyDataChanged()
        //chartView.notifyDataSetChanged()
        
    }
    public func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
        //self.testCollection.isScrollEnabled = true
    }
}
extension ProductPanels: MyChartViewDelegate {
    
    func chartValueNoLongerSelected(_ chartView: ChartViewBase) {
        theLabels!.isHidden = true
        thePeriodSchedule.isHidden = false
        thePeriodSchedule.fadeIn()
        // Do something on deselection
    }
}
extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
}


@objc protocol MyChartViewDelegate {
    @objc optional func chartValueNoLongerSelected(_ chartView: MyLineChartView)
}


open class MyLineChartView: LineChartView {
    
    @objc weak var myChartViewDelegate: MyChartViewDelegate?
    
    private var touchesMoved = false
    
    // Haptic Feedback
    private let impactGenerator = UIImpactFeedbackGenerator(style: .light)
    private let selectionGenerator = UISelectionFeedbackGenerator()
    
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // This is here to prevent the UITapGesture from blocking touches moved from firing
        if gestureRecognizer.isKind(of: NSUITapGestureRecognizer.classForCoder()){
            return false
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
    
    override open func nsuiTouchesBegan(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?) {
        impactGenerator.impactOccurred()
        selectionGenerator.prepare()
        // adds the highlight to the graph when tapped
        super.nsuiTouchesBegan(touches, withEvent: event)
        touchesMoved = false
        if let touch = touches.first {
            let h = getHighlightByTouchPoint(touch.location(in: self))
            
            if h === nil || h == self.lastHighlighted {
                lastHighlighted = nil
                highlightValue(nil, callDelegate: true)
            }
            else {
                lastHighlighted = h
                highlightValue(h, callDelegate: true)
            }
        }
    }
    
    open override func nsuiTouchesEnded(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?) {
        super.nsuiTouchesEnded(touches, withEvent: event)
        myChartViewDelegate?.chartValueNoLongerSelected?(self) // remove the highlight
    }
    
    open override func nsuiTouchesCancelled(_ touches: Set<NSUITouch>?, withEvent event: NSUIEvent?) {
        super.nsuiTouchesCancelled(touches, withEvent: event)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // if a tap turns into a panGesture touches cancelled is called this prevents the highlight from being moved
            if !self.touchesMoved {
                self.myChartViewDelegate?.chartValueNoLongerSelected?(self)
            }
        }
    }
    
    override open func nsuiTouchesMoved(_ touches: Set<NSUITouch>, withEvent event: NSUIEvent?) {
        super.nsuiTouchesMoved(touches, withEvent: event)
        touchesMoved = true
        
        if let touch = touches.first {
            let h = getHighlightByTouchPoint(touch.location(in: self))
            
            if h === nil {
                lastHighlighted = nil
                highlightValue(nil, callDelegate: true)
            }
            else if h == self.lastHighlighted {
                return
            }
            else {
                lastHighlighted = h
                highlightValue(h, callDelegate: true)
                selectionGenerator.selectionChanged()
            }
        }
    }
}
