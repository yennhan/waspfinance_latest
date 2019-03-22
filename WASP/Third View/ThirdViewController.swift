//
//  ThirdViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 22/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate   = self
        tableView.dataSource = self
        //let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        //tap.numberOfTapsRequired = 1
        //view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let theview = UIApplication.shared.windows[0].rootViewController
            as! ParentHomeViewController
        theview.Portfolio.setTitleColor(UIColor.black, for: .normal)
        theview.portfolioUnderline.backgroundColor = UIColor.black
        theview.Home.setTitleColor(UIColor.lightGray, for: .normal)
        theview.Market.setTitleColor(UIColor.lightGray, for: .normal)
        theview.homeUnderline.backgroundColor = UIColor.lightGray
        theview.marketUnderline.backgroundColor = UIColor.lightGray
    }
}
extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstC", for: indexPath) as! firstCTableViewCell
            return cell
        }else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "secondC", for: indexPath) as! secondCTableViewCell
            cell2.collectionCV.delegate = self
            cell2.collectionCV.dataSource = self
            cell2.collectionCV.tag = indexPath.row
            cell2.collectionCV.reloadData()
            return cell2
        }
    }
}

extension ThirdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return 10
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCVCell", for: indexPath)
        return cell
    }
}
