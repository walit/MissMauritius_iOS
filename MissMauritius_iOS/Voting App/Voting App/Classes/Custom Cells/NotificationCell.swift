//
//  NotificationCell.swift
//  Audit
//
//  Created by Rupesh Chhabra on 31/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {


    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Day: UILabel!
    @IBOutlet weak var lbl_Title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setNotificationData(obNot: NotificationModel) {
        
        lbl_Title.text = obNot.title
        lbl_Day.text = obNot.body
        lbl_Time.text = obNot.createdAt
        
       // print("obNot.notifDescription = \(obNot.notifDescription)")
       // lbl_Time.text =  DC.change(date: obNot.time!, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", to: "hh:mm a")
     //   lbl_Day.text =   DC.change(date: obNot.date!, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", to: "dd MMM YYYY")
       //x lbl_Title.text = obNot.notifDescription
    }
    
}
