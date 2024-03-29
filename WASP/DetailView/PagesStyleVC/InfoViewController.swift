//
//  InfoViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 17/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
   
    var theItem: Products!
   
    //var theParent = ProductDetailsViewController()
   
    @IBOutlet weak var theTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        theTableView.delegate = self
        theTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(passINFO), name: NSNotification.Name("passINFO"), object: nil)
    }
    
    @objc func passINFO(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? Products else { return }
        print ("text: \(text)")
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCellOne", for: indexPath) as! InfoOneTableViewCell
        return cell
        } else if indexPath.row == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "infoCellTwo", for: indexPath) as! InfoTwoTableViewCell
            return cell2
        }else {
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "infoCellThree", for: indexPath) as! InfoThreeTableViewCell
            return cell3
        }
        
    }
    
    
}
