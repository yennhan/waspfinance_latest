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
    @objc var _productAuthor: String?

    
    
    class func dynamoDBTableName() -> String {
        return "product"
    }
    
    class func hashKeyAttribute() -> String {
        return "_productID"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "_productID" : "product_id",
            "_productName" : "product_name",
            "_productAuthor" : "p_author",
           
        ]
    }
}
