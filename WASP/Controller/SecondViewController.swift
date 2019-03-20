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
   
    let theItems = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        //panelManager.show(panel: panel, config: panelConfiguration)
        //panelManager.dismiss()
        theTableCV.delegate = self
        theTableCV.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let theview = UIApplication.shared.windows[0].rootViewController
            as! ParentHomeViewController
        theview.Market.setTitleColor(UIColor.black, for: .normal)
        theview.Home.setTitleColor(UIColor.lightGray, for: .normal)
        theview.homeUnderline.backgroundColor = UIColor.lightGray
        theview.marketUnderline.backgroundColor = UIColor.black
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "theMarket", for: indexPath)
        cell.layer.cornerRadius = 1.0
        cell.layer.borderColor = UIColor.darkGray.cgColor
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

