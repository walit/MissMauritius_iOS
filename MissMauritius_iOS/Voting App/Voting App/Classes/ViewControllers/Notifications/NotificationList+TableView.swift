//
//  NotificationList+TableView.swift
//  Audit
//
//  Created by Rupesh Chhabra on 22/03/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

extension NotificationListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (notificationList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        if (notificationList?.count)! > 0 {
            cell.setNotificationData(obNot: (notificationList?[indexPath.row])!)
        } 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
 
}
