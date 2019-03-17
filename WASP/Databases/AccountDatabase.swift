//
//  Database.swift
//  WASP
//
//  Created by Leow Yenn Han on 07/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import Foundation
import UIKit
import AWSDynamoDB

class Account: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    @objc var _sub: String?
    @objc var _email: String?
    @objc var _investedamount: NSNumber?
    @objc var _name: String?
    
    
    class func dynamoDBTableName() -> String {
        return "wasp_account"
    }
    
    class func hashKeyAttribute() -> String {
        return "_sub"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "_sub" : "sub",
            "_email" : "email",
            "_investedamount" : "invested_amount",
            "_name" : "name",
        ]
    }
}
