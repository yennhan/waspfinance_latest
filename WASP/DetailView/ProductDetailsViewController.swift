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

    
    @IBOutlet weak var theInfo: UIButton!
    @IBOutlet weak var theCharges: UIButton!
    @IBOutlet weak var theCalculator: UIButton!
    
    @IBOutlet weak var infoUnderline: UILabel!
    @IBOutlet weak var chargesUnderline: UILabel!
    @IBOutlet weak var calculatorUnderline: UILabel!
    
    var theNameB: String!
    //items display
    @IBOutlet weak var bondName: UILabel!
    @IBOutlet weak var bondPic: UIImageView!
    @IBOutlet weak var byCompany: UILabel!
    @IBOutlet weak var theDesc: UILabel!
    
    
    //coming soon datas
    let cityImage = ["https://s3-ap-southeast-1.amazonaws.com/wasp-images/application/drb.jpg"]

    

    @IBOutlet weak var logoImage: UIImageView!
    var thePVC: DetailPageViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewsegue"{
            if segue.destination.isKind(of: DetailPageViewController.self){
                thePVC = segue.destination as! DetailPageViewController
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.navigationController?.setToolbarHidden(true, animated: true)
        //setup image and make rounded
        logoImage.kf.setImage(with: URL(string: cityImage[0]))
        makeRounded(theImage: logoImage)
        bondName.text = theNameB

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
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

    @IBAction func goToInfo(_ sender: Any) {
        theInfo.setTitleColor(UIColor.black, for: .normal)
        theCalculator.setTitleColor(UIColor.lightGray, for: .normal)
        theCharges.setTitleColor(UIColor.lightGray, for: .normal)
        
        infoUnderline.backgroundColor = UIColor.black
        calculatorUnderline.backgroundColor = UIColor.lightGray
        chargesUnderline.backgroundColor = UIColor.lightGray
        thePVC.setViewcontrollerFromIndex(index: 0)
    }
    
    @IBAction func goToCharges(_ sender: Any) {
        theCharges.setTitleColor(UIColor.black, for: .normal)
        chargesUnderline.backgroundColor = UIColor.black
        
        theInfo.setTitleColor(UIColor.lightGray, for: .normal)
        theCalculator.setTitleColor(UIColor.lightGray, for: .normal)
        infoUnderline.backgroundColor = UIColor.lightGray
        calculatorUnderline.backgroundColor = UIColor.lightGray
        thePVC.setViewcontrollerFromIndex(index: 1)
    }
    
    @IBAction func goToCalculator(_ sender: Any) {
        theCalculator.setTitleColor(UIColor.black, for: .normal)
        calculatorUnderline.backgroundColor = UIColor.black
        
        theCharges.setTitleColor(UIColor.lightGray, for: .normal)
        chargesUnderline.backgroundColor = UIColor.lightGray
        theInfo.setTitleColor(UIColor.lightGray, for: .normal)
        infoUnderline.backgroundColor = UIColor.lightGray
        
        thePVC.setViewcontrollerFromIndex(index: 2)
    }
    @IBAction func investNowButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PurchaseViewController") as! PurchaseViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}

