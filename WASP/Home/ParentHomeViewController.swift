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
    
    @IBOutlet weak var theChangeMenu: NSLayoutConstraint!
    @IBOutlet weak var theTopMenu: NSLayoutConstraint!
    var sideMenuOpen = false
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("toggleSideMenu"), object: nil)
        
        //calling all profile,sign out and settings
         NotificationCenter.default.addObserver(self, selector: #selector(showProfile), name: NSNotification.Name("showProfile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSetttings), name: NSNotification.Name("showSettings"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(LogOut), name: NSNotification.Name("showSignIn"), object: nil)

        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
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

    @IBAction func theSideMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("toggleSideMenu"), object: nil)
    }
    @objc func showProfile() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "showProfile") as! ProfileViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    @objc func showSetttings() {
       // performSegue(withIdentifier: "ShowSettings", sender: nil)
        
    }
    @objc func LogOut() {
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            print("Screen edge swiped!")
        }
    }
    @objc func toggleSideMenu(){
        if sideMenuOpen {
            sideMenuOpen = false
            theChangeMenu.constant = 0
            theTopMenu.constant = +240
            
        }else {
            sideMenuOpen = true
            theChangeMenu.constant = -240
            theTopMenu.constant = 0
        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    @objc func ifMenuSwipeOut() {
        if sideMenuOpen == true {
            sideMenuOpen = false
            theChangeMenu.constant = 0
            theTopMenu.constant = +240
            
        }
    }
   
}
