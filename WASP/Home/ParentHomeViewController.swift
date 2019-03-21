//
//  ParentHomeViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 13/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognitoIdentityProvider

class ParentHomeViewController: UIViewController {
    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    var thePVC: HomePageViewController!
    @IBOutlet weak var Home: UIButton!
    @IBOutlet weak var Products: UIButton!
    @IBOutlet weak var Portfolio: UIButton!
    @IBOutlet weak var Market: UIButton!
    
    @IBOutlet weak var homeUnderline: UILabel!
    @IBOutlet weak var marketUnderline: UILabel!
    @IBOutlet weak var portfolioUnderline: UILabel!
    @IBOutlet weak var productUnderline: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PVCsegue"{
            if segue.destination.isKind(of: HomePageViewController.self){
                thePVC = segue.destination as! HomePageViewController
               
               
            }
        }
    }

    /*override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    } */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
        Home.setTitleColor(UIColor.black, for: .normal)
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
                
            })
            return nil
        }
    }
    

    
    @IBOutlet var theStackButton: [UIButton]!
    
   @IBAction func theTypeSelected(_ sender: UIButton) {
        theStackButton.forEach({ $0.setTitleColor(UIColor.lightGray, for: .normal) })
        sender.setTitleColor(UIColor.black, for: .normal)
        
    }
 
    @IBAction func goToHome(_ sender: Any) {
        thePVC.setViewcontrollerFromIndex(index: 0)
    }
    @IBAction func goToMarket(_ sender: Any) {
       
        thePVC.setViewcontrollerFromIndex(index: 1)
    }
    @IBAction func goToPortfolio(_ sender: Any) {
        thePVC.setViewcontrollerFromIndex(index: 2)
    }
    @IBAction func goToProduct(_ sender: Any) {
        thePVC.setViewcontrollerFromIndex(index: 3)
    }
}
