//
//  ItemsDatabase.swift
//  WASP
//
//  Created by Leow Yenn Han on 07/03/2019.
//  Copyright © 2019 wasp venture. All rights reserved.
//

import Foundation
import UIKit
import AWSDynamoDB

class Products: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    @objc var _productID: String?
    @objc var _productName: String?
    @objc var _productRatings: String?
    @objc var _tenure: NSNumber?
    @objc var _return: NSNumber?
    @objc var _crowdfunding: NSArray?
    @objc var _info1: NSArray?

    
    
    class func dynamoDBTableName() -> String {
        return "product_mobile"
    }
    
    class func hashKeyAttribute() -> String {
        return "_productID"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "_productID" : "productID",
            "_productName" : "name",
            "_productRatings" : "Ratings",
            "_tenure": "Tenure",
            "_return": "Return",
            "_crowdfunding": "crowdfunding"
    
        ]
    }
}
