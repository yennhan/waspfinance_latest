//
//  HomeViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 25/02/2019.
//  Copyright © 2019 . All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
import AWSDynamoDB
import Charts
import Kingfisher
import SkeletonView

class HomeViewController: UIViewController,ChartViewDelegate{

    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    var scrollPoint: CGPoint?
    var endPoint: CGPoint?
    var scrollingTimer: Timer?
    var scrollingUp = false
    
    let bondName = ["RHB IMTN 5.060% 12.02 2049-TRANCHE 10","DRB Bond","Genting ","Ambank "]
    let bondPrice = ["101.50","100.00","98.50","105.50"]
    let fluctuactionPrice = ["+0.05","+1.10","-1.50","+0.50"]
    let picURL = ["https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/rhbbank.png","https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/drb.jpg","https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/genting.png","https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/ambank.png"]
    
    //coming soon datas
    let cityImage = ["https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/city.jpeg","https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/city4.jpeg","https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/city2.jpeg","https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/city3.jpeg"]
    let theUpcomingBond = ["Tenaga Berhad","Eco World","Sunway(Sukuk)"]
    let upcomingPicURL = ["https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/tenaga.jpg","https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/ecoworld.png","https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/sunway.png"]
    let interestRate  = ["6%","5.8%","7%","6.2%"]
    let ratings = ["AA3 (RAM)","P1 (RAM)","AAA (RAM)","AAB (MARC)"]
    let tenure = ["10","15","3","5"]
    var gradientLayer: CAGradientLayer!
    var theLabels: UILabel!
    var theView: UIView!
    
    
    //database variable
    var productArray: [Products] = []
    var pName: [String] = []
    @IBOutlet weak var theHomeTableView: UITableView!

    var theViewCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        getAllProducts()
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.setToolbarHidden(true, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        let theview = UIApplication.shared.windows[0].rootViewController as! ParentHomeViewController
        theview.Home.setTitleColor(UIColor.black, for: .normal)
        theview.Market.setTitleColor(UIColor.lightGray, for: .normal)
        theview.homeUnderline.backgroundColor = UIColor.black
        theview.marketUnderline.backgroundColor = UIColor.lightGray
        theview.Portfolio.setTitleColor(UIColor.lightGray, for: .normal)
        theview.portfolioUnderline.backgroundColor = UIColor.lightGray
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refresh()
        theHomeTableView.showsVerticalScrollIndicator = false
       
    }
    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
                //let yourName  = self.response?.userAttributes![2].value?.components(separatedBy: " ")
                //self.theNAME.text = "Welcome Back, \(yourName![0])"
            })
            return nil
        }
    }
    @IBAction func SignOut(_ sender: AnyObject) {
        self.user?.signOut()
        self.title = nil
        self.response = nil
        self.refresh()
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            let theview = UIApplication.shared.windows[0].rootViewController
                as! ParentHomeViewController
            theview.toggleSideMenu()
        }
    }
}
extension HomeViewController:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell0 = tableView.dequeueReusableCell(withIdentifier: "graph", for: indexPath) as! HomeTableViewCell
            //cell0.thePieChart.reloadInputViews()
            return cell0
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "trendingCell", for: indexPath) as! TopPicksTableViewCell
            cell.theCV.delegate = self
            cell.theCV.dataSource = self
            cell.theCV.tag = indexPath.row
            theViewCollection = cell.theCV
            
            cell.reloadInputViews()
            cell.theCV.reloadData()
            //makeCards(theCard: cell)
            return cell
        //cell.topBonds.reloadData()
        }else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "TopSupportCell",for: indexPath) as! MyPortfolioTableViewCell
            cell2.topSupporterCV.delegate   = self
            cell2.topSupporterCV.dataSource = self
            cell2.topSupporterCV.tag        = indexPath.row
            cell2.topSupporterCV.reloadData()
            return cell2
        }
    }
    
}
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return productArray.count
        }else if collectionView.tag == 2 {
                return picURL.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1{
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "topTrend", for: indexPath) as! TopPicksCollectionViewCell
            cell1.topPickImage.kf.setImage(with:  URL(string: cityImage[indexPath.row]))
            let proName = productArray[0]._productName!
            cell1.bondName.text = proName
            cell1.topPickImage.layer.borderColor = UIColor.lightGray.cgColor
            cell1.topPickImage.layer.borderWidth = 0.2
            cell1.theLogoImage.kf.setImage(with: URL(string: picURL[indexPath.row]))
            //makeRounded(theImage: cell1.theLogoImage)
            cell1.bondReturn.text = "Return: \(interestRate[indexPath.row])"
            cell1.bondRating.text = "Ratings: \(ratings[indexPath.row])"
            cell1.bondTenure.text = "Tenure(yrs): \(tenure[indexPath.row])"
            cell1.layer.borderColor = UIColor.lightGray.cgColor
            cell1.layer.borderWidth = 0.4
            cell1.layer.cornerRadius = 7.0
            cell1.progressBar.progress = 0.5
            return cell1
        }else if collectionView.tag == 2{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "myHolding", for: indexPath) as! MyPortfolioCollectionViewCell
            cell2.theImage.kf.setImage(with:  URL(string: picURL[indexPath.row]))
            cell2.theName.text = bondName[indexPath.row]
            cell2.layer.borderColor = UIColor.gray.cgColor
            cell2.layer.borderWidth = 0.2
            cell2.theImage.layer.borderColor = UIColor.gray.cgColor
            cell2.theImage.layer.borderWidth = 0.2
            cell2.layer.cornerRadius = 7.0
            return cell2
        }else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myBonds", for: indexPath) as! HomeCollectionViewCell
            cell.bondName.text = bondName[indexPath.row]
            cell.bondPrice.text = bondPrice[indexPath.row]
            if fluctuactionPrice[indexPath.row].first?.description == "+"
            {
                cell.priceChange.textColor = UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 1)
                cell.priceChange.text = fluctuactionPrice[indexPath.row]
            }else {
                cell.priceChange.textColor = UIColor.red
                cell.priceChange.text = fluctuactionPrice[indexPath.row]
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "productDetail") as! ProductDetailsViewController
        self.present(vc, animated: true, completion: nil)
    }
    func makeRounded(theImage: UIImageView) {
        
        theImage.layer.borderWidth = 1
        theImage.layer.masksToBounds = false
        theImage.layer.borderColor = UIColor.lightGray.cgColor
        theImage.layer.cornerRadius = theImage.frame.height/2
        theImage.clipsToBounds = true
    }
    func makeCards(theCard:UIView){
        //set corner radius
        theCard.layer.cornerRadius  = 7.0
        theCard.layer.masksToBounds = true
        
        //set shadow effect
        theCard.layer.shadowColor  = UIColor.black.cgColor
        theCard.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        theCard.layer.shadowOpacity = 0.5
        theCard.layer.shadowRadius = 10.0
        theCard.layer.borderWidth = 0.1
        theCard.layer.shadowPath = UIBezierPath(rect: theCard.bounds).cgPath
        
        
    }
    
}   
extension HomeViewController {
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //let graphPoint = chartView.getMarkerPosition(highlight: highlight)
        theLabels.isHidden = false
        theLabels.translatesAutoresizingMaskIntoConstraints = true
        theLabels.center.x = highlight.xPx
        //theLabels!.frame.origin.x = highlight.xPx
        theLabels.text = "\(entry.y)"
        theLabels.textColor = UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 1)
        //self.testCollection.isScrollEnabled = false
        //var set1 = LineChartDataSet()
        //set1 = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        //chartView.data?.notifyDataChanged()
        //chartView.notifyDataSetChanged()
        
    }
    public func chartValueNothingSelected(_ chartView: ChartViewBase) {
        theLabels!.isHidden = true
        //self.testCollection.isScrollEnabled = true
    }
}

extension HomeViewController {
    func getAllProducts() {
        let queryExpression = AWSDynamoDBScanExpression()
        // 2) Make the query
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        dynamoDbObjectMapper.scan(Products.self, expression: queryExpression).continueWith(block: { (task:AWSTask!) -> AnyObject? in
            if task.result != nil {
                DispatchQueue.main.async(execute: {
                    let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                    self.productArray = paginatedOutput.items as! [Products]
                    self.theViewCollection.reloadData()
                })
            }
            return nil
        })
            
        }
    
    
    func queryAccount() {
        
        // 1) Configure the query
        let queryExpression = AWSDynamoDBQueryExpression()
        queryExpression.keyConditionExpression = "#sub = :sub"
        queryExpression.expressionAttributeNames = [
            "#sub": "sub"
            
        ]
        
        queryExpression.expressionAttributeValues = [
            ":sub" : "68aa7ef8-4fee-4dcb-8a5d-1c75abcf655c"
            
        ]
        
        // 2) Make the query
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.query(Account.self, expression: queryExpression) { (output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for books in output!.items {
                    let booksItem = books as? Account
                    print("\(booksItem!._email!)")
                }
            }
        }
    }
    func queryProducts() {
        // 1) Configure the query
        let queryExpression = AWSDynamoDBQueryExpression()
        queryExpression.keyConditionExpression = "#productID = :productID"
        
        queryExpression.expressionAttributeNames = [
            "#productID": "productID"
            
        ]
        
        queryExpression.expressionAttributeValues = [
            ":productID" : "product1"
            
        ]
        
        // 2) Make the query
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.query(Products.self, expression: queryExpression) { (output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                for items in output!.items {
                    let theItem = items as? Products
                    print(theItem!._crowdfunding![0])
                    
                }
            }
        }
    }
}

/* extension HomeViewController{
    func makeLineChart() {
        self.theLineChart.data = setLineChartData()
        self.theLineChart.legend.enabled = false
        self.theLineChart.xAxis.drawGridLinesEnabled = true
        self.theLineChart.xAxis.drawAxisLineEnabled = true
        self.theLineChart.xAxis.labelTextColor = UIColor.white
        self.theLineChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.theLineChart.leftAxis.drawLabelsEnabled = true
        self.theLineChart.rightAxis.drawLabelsEnabled = true
        self.theLineChart.rightAxis.drawGridLinesEnabled = true
        self.theLineChart.leftAxis.drawGridLinesEnabled = false
        self.theLineChart.leftAxis.labelTextColor = UIColor.white
        self.theLineChart.data?.highlightEnabled = true
        self.theLineChart.doubleTapToZoomEnabled = false
        self.theLineChart.pinchZoomEnabled = false
        
    }
    func setLineChartData() -> LineChartData  {
        let val = [ChartDataEntry(x:1,y:1),ChartDataEntry(x:2,y:10),ChartDataEntry(x:3,y:30),ChartDataEntry(x:4,y:4),ChartDataEntry(x:5,y:50),ChartDataEntry(x:6,y:6),ChartDataEntry(x:7,y:60),ChartDataEntry(x:8,y:26),ChartDataEntry(x:9,y:65),ChartDataEntry(x:10,y:99),ChartDataEntry(x:11,y:110),ChartDataEntry(x:12,y:140),ChartDataEntry(x:13,y:56),ChartDataEntry(x:14,y:150)]
        let set  = LineChartDataSet(values:val,label:"The Chart")
        
        //Gradient Building
        let gradientColors = [UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 0.5)
            , UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 1)] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        //let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        //set.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        set.fillColor = UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 0.2)

        set.colors = [UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 1)]
        //set.mode = .cubicBezier
        set.lineWidth = 2.0
        set.drawCirclesEnabled = false
        set.drawCircleHoleEnabled = false
        set.drawFilledEnabled = true
        set.fillAlpha = 0.9
        set.drawValuesEnabled = false
        set.valueColors = [UIColor.black]
        set.highlightEnabled = true
        set.highlightColor = UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 1)
        set.highlightLineWidth = 1.5
        set.drawHorizontalHighlightIndicatorEnabled = false
        //set.setDrawHighlightIndicators(true)
        let data = LineChartData(dataSet: set)
        return data
        
    }
} */
extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        if scrollView.tag == 1 {
        let layout  = self.theViewCollection.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludeSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offSet = targetContentOffset.pointee
        let index = (offSet.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        
        let roundedIndex = round(index)
        offSet = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offSet
        
        }
        
    }
}

