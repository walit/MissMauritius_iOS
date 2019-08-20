//
//  EventCell.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 25/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBAction func btn_ReadMore(_ sender: Any) {
       
    }
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var imgView_Event: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setEventData(obEve: EventModel?) {
        imgView_Event.sd_setImage(with: URL(string: obEve!.eventImage!), placeholderImage: UIImage.init(named: "img_user"))
        lbl_Title.text = obEve?.eventTitle
        lbl_Date.text = String(format: "%@ at %@", obEve!.eventDate!, obEve!.eventTime!)
    }
    
}
