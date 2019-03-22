//
//  SideMenuVC.swift
//  WASP
//
//  Created by Leow Yenn Han on 23/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class SideMenuVC: UITableViewController {
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
