//
//  SecondViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 13/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
