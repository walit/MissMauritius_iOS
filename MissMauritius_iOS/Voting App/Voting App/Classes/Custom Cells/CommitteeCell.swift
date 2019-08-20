//
//  CommitteeCell.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 14/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class CommitteeCell: UITableViewCell {

    @IBOutlet weak var lbl_FullName: UILabel!
    @IBOutlet weak var lbl_About: UILabel!
    @IBOutlet weak var lbl_Detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCommitteeData(obCom: CommitteeModel?) {
        lbl_FullName.text = obCom?.name
        lbl_About.text = obCom?.about
        lbl_Detail.text = obCom?.detail
    }
    
}
