//
//  HomePageViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 13/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class HomePageViewController: UIPageViewController {
    
    lazy var subViewController: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil ).instantiateViewController(withIdentifier: "HomePageID") as! HomeViewController,
            UIStoryboard(name: "Main", bundle: nil ).instantiateViewController(withIdentifier: "secondVC") as! SecondViewController,
            UIStoryboard(name: "Main", bundle: nil ).instantiateViewController(withIdentifier: "ThirdPageID") as! ThirdViewController,
            UIStoryboard(name: "Main", bundle: nil ).instantiateViewController(withIdentifier: "secondVC") as! SecondViewController,
        ]
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate   = self
        
        setViewcontrollerFromIndex(index: 0)

    }
    func setViewcontrollerFromIndex(index:Int){
        self.setViewControllers([subViewController[index]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }
}
extension HomePageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewController.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewController.index(of: viewController) ?? 0
        if currentIndex <= 0 {
             NotificationCenter.default.post(name: NSNotification.Name("toggleSideMenu"), object: nil)
            return nil
           
        } else
            {
                
            return subViewController[currentIndex-1]
            }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewController.index(of: viewController) ?? 0
        if currentIndex >= subViewController.count-1 {
            return nil
        } else
            {
            return subViewController[currentIndex+1]
            }
    }
    
    
    
}

    
