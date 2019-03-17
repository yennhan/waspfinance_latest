//
//  ProductPanels.swift
//  WASP
//
//  Created by Leow Yenn Han on 13/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit
import Panels

class ProductPanels: UIViewController,Panelable {

    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    @IBOutlet weak var headerPanel: UIView!
    @IBOutlet weak var theImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRounded(theImage: theImage)
        // Do any additional setup after loading the view.
    }
    
    func makeRounded(theImage: UIImageView) {
        
        theImage.layer.borderWidth = 1
        theImage.layer.masksToBounds = false
        theImage.layer.borderColor = UIColor.lightGray.cgColor
        theImage.layer.cornerRadius = theImage.frame.height/2
        theImage.clipsToBounds = true
    }
}
