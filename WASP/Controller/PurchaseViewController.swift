//
//  PurchaseViewController.swift
//  WASP
//
//  Created by Leow Yenn Han on 19/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var theView: UIView!
    
    @IBOutlet weak var theAmount: UITextField!
    
    @IBOutlet weak var termsCView: UIView!
    
    @objc func keyboardWillChange(notification: Notification){
        guard let keyboardRect  = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        }else {
        view.frame.origin.y = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        theView.layer.borderColor = UIColor(red: 69/255, green: 109/255, blue: 155/255, alpha: 1).cgColor
        theView.layer.borderWidth = 0.8
        theAmount.layer.borderColor = UIColor(red: 69/255, green: 109/255, blue: 155/255, alpha: 1).cgColor
        theAmount.layer.borderWidth = 0.5
        theAmount.delegate = self

        //Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(singleTap)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification, object:nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification, object:nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillChangeFrameNotification, object:nil)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   

}
