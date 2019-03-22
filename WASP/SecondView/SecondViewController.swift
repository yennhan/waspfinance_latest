//
//  SecondViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 13/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit
import SPStorkController
class SecondViewController: UIViewController {

    //lazy var panelManager = Panels(target:self)
    @IBOutlet weak var theTableCV: UITableView!
    //let panel = UIStoryboard.instantiatePanel(identifier: "ProductPanels")
    //let panelConfiguration = PanelConfiguration(size: .thirdQuarter)
   
    let theItems = ["ACSMMK 6.650% Perpetual Corp (MYR)","ACSMMK 6.650% Perpetual Corp (MYR)","CIMBMK 5.800% Perpetual Corp (MYR)","DRBHMK 6.100% 14Feb2022 Corp (MYR)","DRBHMK 6.300% 29Jun2021 Corp (MYR)","ECWIMK 6.400% 25Oct2021 Corp (MYR)","FIRTSP 5.680% Perpetual Corp (SGD)","GEMAU 5.500% 18May2019 Corp (SGD)","GGRSP 5.350% 05Aug2019 Corp (MYR)"]
    let price = ["101.25","102.50","99.50","100.00","98.50","102.00","101.75","105.50","100.00"]
    let changePercentage = ["+0.55%","-0.50%","+2.00%","+3.00%","-1.50%","+0.75%","-0.25%","+0.50%","+0.00%"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //panelManager.show(panel: panel, config: panelConfiguration)
        //panelManager.dismiss()
        theTableCV.delegate = self
        theTableCV.dataSource = self
       
    }
    @IBOutlet weak var theTotalBonds: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        let theview = UIApplication.shared.windows[0].rootViewController
            as! ParentHomeViewController
        theview.Market.setTitleColor(UIColor.black, for: .normal)
        theview.Home.setTitleColor(UIColor.lightGray, for: .normal)
        theview.homeUnderline.backgroundColor = UIColor.lightGray
        theview.marketUnderline.backgroundColor = UIColor.black
        theview.Portfolio.setTitleColor(UIColor.lightGray, for: .normal)
        theview.portfolioUnderline.backgroundColor = UIColor.lightGray
        theTotalBonds.text = "Total Bonds: \(theItems.count)"
    }

}

extension SecondViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstMarket", for: indexPath) as! FirstTableViewCell
        cell.theCV.delegate   = self
        cell.theCV.dataSource = self
        cell.theCV.tag = indexPath.row
        
        cell.theCV.reloadData()
        return cell
    }
    
}

extension SecondViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "theMarket", for: indexPath) as! FirstCollectionViewCell
        
        cell.tradeTitle.text = theItems[indexPath.row]
        cell.tradeLastPrice.text = price[indexPath.row]
        if changePercentage[indexPath.row].first?.description == "+"
        {
            cell.tradePriceChange.backgroundColor = UIColor(red: 97/255, green: 197/255, blue: 137/255, alpha: 1)
            cell.tradePriceChange.text = changePercentage[indexPath.row]
        }else {
            cell.tradePriceChange.backgroundColor = UIColor.red
            cell.tradePriceChange.text = changePercentage[indexPath.row]
        }
        //cell.layer.cornerRadius = 4.0
        //cell.layer.borderColor = UIColor.lightGray.cgColor
        //cell.layer.borderWidth = 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"ProductPanels",bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductPanels") as! ProductPanels
        let controller = vc
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.customHeight = 700
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller, animated: true, completion: nil)
        
    }
  
}

