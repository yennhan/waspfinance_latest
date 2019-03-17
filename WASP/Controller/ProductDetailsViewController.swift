//
//  ProductDetailsViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 13/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit
import Panels
import AWSCognitoIdentityProvider
import AWSDynamoDB
import Kingfisher
class ProductDetailsViewController: UIViewController {
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    // define a variable to store initial touch position
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)

    lazy var panelManager = Panels(target: self)
    //coming soon datas
    let cityImage = ["https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/drb.jpg"]

    

    @IBOutlet weak var logoImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        let panel = UIStoryboard.instantiatePanel(identifier: "ProductPanels")
    
        let panelConfiguration = PanelConfiguration(size: .half,visibleArea: 300.0)
        
        logoImage.kf.setImage(with: URL(string: cityImage[0]))
        makeRounded(theImage: logoImage)
        // To present the panel
        panelManager.show(panel: panel, config: panelConfiguration)
        // To dismiss the panel
        panelManager.dismiss()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func swipeDownDismiss(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    func makeRounded(theImage: UIImageView) {
        
        theImage.layer.borderWidth = 1
        theImage.layer.masksToBounds = false
        theImage.layer.borderColor = UIColor.lightGray.cgColor
        theImage.layer.cornerRadius = theImage.frame.height/2
        theImage.clipsToBounds = true
    }

}
