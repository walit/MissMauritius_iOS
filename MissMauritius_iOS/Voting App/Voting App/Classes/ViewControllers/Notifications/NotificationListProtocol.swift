//
//  NotificationListProtocol.swift
//  Audit
//
//  Created by Rupesh Chhabra on 22/03/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

protocol NotificationListDelegate {
    func getNotificationList()
    
}

extension NotificationListViewController: NotificationListDelegate {
    func getNotificationList() {
        /// API code here
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.Common.NotificationList, methodType: 2, forContent: 3, OnView: self, withParameters: NSMutableDictionary()) { (dictJson, status ) in
            if status == 1 { // Means user logined
                let arrNotif = dictJson["data"] as! NSArray
                for i in 0..<arrNotif.count {
                    autoreleasepool {
                        let obRequest:NotificationModel? = NotificationModel()
                        obRequest?.initWith(dict: arrNotif[i] as! NSDictionary)
                        self.notificationList?.append(obRequest!)
                    }
                }
                self.tblView?.reloadData()
            }
        }
    }
   
}
