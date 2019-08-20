//
//  NotificationModel.swift
//  Audit
//
//  Created by Rupesh Chhabra on 31/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class NotificationModel: NSObject {
    
    /*body = "10 vote added to your account";
     "created_at" = "2019-06-28 14:31:26";
     "notification_type" = "vote_purchase";
     "reference_id" = 38;
     title = "Miss Mauritius";
     "user_id" = 1;*/
    
    var body:String? = String()
    var createdAt:String? = String()
    var notificationType:String? = String()
    var referenceId:String? = String()
    var title:String? = String()
    var userId:String? = String()
    

    override init() { }
    
    func initWith(dict: NSDictionary) {
        self.body = dict["body"] as? String
        self.title = dict["title"] as? String
        self.createdAt = dict["created_at"] as? String
        self.notificationType = dict["notification_type"] as? String
        self.referenceId = dict["reference_id"] as? String
        self.userId = dict["user_id"] as? String
    }
}
