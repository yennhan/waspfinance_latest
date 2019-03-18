//
//  DetailPageViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 17/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class DetailPageViewController: UIPageViewController {
    
    var parentCV = ProductDetailsViewController()
    var theIndex:Int = 0
    
    lazy var subViewController: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil ).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController,
            UIStoryboard(name: "Main", bundle: nil ).instantiateViewController(withIdentifier: "ChargesViewController") as! ChargesViewController,
            UIStoryboard(name: "Main", bundle: nil ).instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController,
            ]
    }()
    override func didMove(toParent parent: UIViewController?) {
        self.parentCV = parent as! ProductDetailsViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate   = self
        setViewcontrollerFromIndex(index: 0)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        changeViewSelection(theNumber: 0)
    }
    func setViewcontrollerFromIndex(index:Int){
       
        self.setViewControllers([subViewController[index]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }

}
extension DetailPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewController.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewController.index(of: viewController) ?? 0
        theIndex = subViewController.index(of: viewController) ?? 0
        
        if currentIndex <= 0 {
            
            return nil
            
        } else
        {
            
            return subViewController[currentIndex-1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewController.index(of: viewController) ?? 0
        theIndex = subViewController.index(of: viewController) ?? 0
        if currentIndex >= subViewController.count-1 {
           
            return nil
        } else
        {
            
            return subViewController[currentIndex+1]
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let theNumber = subViewController.index(of: pendingViewControllers[0]) ?? 0
        changeViewSelection(theNumber: theNumber)
    }

    func changeViewSelection(theNumber: Int){
        
        if theNumber == 0 {
            parentCV.theInfo.setTitleColor(UIColor.black, for: .normal)
            parentCV.infoUnderline.backgroundColor = UIColor.black
            parentCV.theCalculator.setTitleColor(UIColor.lightGray, for: .normal)
            parentCV.theCharges.setTitleColor(UIColor.lightGray, for: .normal)
            
            parentCV.calculatorUnderline.backgroundColor = UIColor.lightGray
            parentCV.chargesUnderline.backgroundColor = UIColor.lightGray
        }else if theNumber == 1{
            parentCV.theCharges.setTitleColor(UIColor.black, for: .normal)
            parentCV.chargesUnderline.backgroundColor = UIColor.black
            
            parentCV.theInfo.setTitleColor(UIColor.lightGray, for: .normal)
            parentCV.theCalculator.setTitleColor(UIColor.lightGray, for: .normal)
            parentCV.infoUnderline.backgroundColor = UIColor.lightGray
            parentCV.calculatorUnderline.backgroundColor = UIColor.lightGray
            
        }else {
            parentCV.theCalculator.setTitleColor(UIColor.black, for: .normal)
            parentCV.calculatorUnderline.backgroundColor = UIColor.black
            
            parentCV.theCharges.setTitleColor(UIColor.lightGray, for: .normal)
            parentCV.chargesUnderline.backgroundColor = UIColor.lightGray
            parentCV.theInfo.setTitleColor(UIColor.lightGray, for: .normal)
            parentCV.infoUnderline.backgroundColor = UIColor.lightGray
        }
    }
    
    
}
