//
//  SideMenuVC.swift
//  WASP
//
//  Created by Leow Yenn Han on 23/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class SideMenuVC: UITableViewController {
    override func viewDidLoad() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .left
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            NotificationCenter.default.post(name: NSNotification.Name("toggleSideMenu"), object: nil)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 1: NotificationCenter.default.post(name: NSNotification.Name("showProfile"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("showSettings"), object: nil)
        case 3: NotificationCenter.default.post(name: NSNotification.Name("showSignIn"), object: nil)
        default: break
            
        }
    }

}
