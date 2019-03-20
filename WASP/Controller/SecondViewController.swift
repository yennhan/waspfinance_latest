//
//  SecondViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 13/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit
import Panels
class SecondViewController: UIViewController {

    lazy var panelManager = Panels(target:self)
    override func viewDidLoad() {
        super.viewDidLoad()
        let panel = UIStoryboard.instantiatePanel(identifier: "ProductPanels")
        let panelConfiguration = PanelConfiguration(size: .half)
        
        // To present the panel
        panelManager.show(panel: panel, config: panelConfiguration)
            // To dismiss the panel
        panelManager.dismiss()
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
