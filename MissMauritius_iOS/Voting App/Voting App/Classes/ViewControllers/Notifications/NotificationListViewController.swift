//
//  NotificationListViewController.swift
//  Audit
//
//  Created by Rupesh Chhabra on 31/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class NotificationListViewController: UIViewController {
    //MARK: Variable & Outlets
    var pageno = 1
    var lodingApi: Bool!
    var delegate: NotificationListDelegate?
    var notificationList:[NotificationModel]? = [NotificationModel]()
    @IBOutlet weak var tblView: UITableView?
    @IBOutlet weak var lbl_NoData: UILabel!
    
    //MARK: View Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView?.tableFooterView = UIView()
        delegate = self
        // Do any additional setup after loading the view.
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (Preferences?.bool(forKey: "isLogin"))! {
            lbl_NoData.alpha = 0.0
            tblView?.alpha = 1.0
            notificationList?.removeAll()
            tblView?.reloadData()
            delegate?.getNotificationList()
        } else {
            lbl_NoData.alpha = 1.0
            tblView?.alpha = 0.0
        }
    }

    //MARK: Button Actions:
    
    @IBAction func btn_Back(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Supporting Methods
   
}
