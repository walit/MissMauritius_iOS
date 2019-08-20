//
//  MenuViewCell.swift
//  Individual App
//
//  Created by Rupesh Chhabra on 23/04/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {

    @IBOutlet weak var imgView_Background: UIImageView!
    @IBOutlet weak var lbl_Line: UILabel!
    @IBOutlet weak var imgWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var imgView_Icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setMenuData(obMenu: MenuModel?) {
      
        lbl_Name.text = obMenu?.name!
        if obMenu?.icon?.count == 0 {
            imgWidthConstraint.constant = 0
             lbl_Name.textColor = UIColor.black
        } else {
            imgWidthConstraint.constant = 30
        }
        
        if obMenu?.isSelected == 1 {
            imgView_Icon.image = UIImage(named: (obMenu?.selectedIcon)!)
            lbl_Name.textColor = CustomColors.themeColorGreen
            imgView_Background.backgroundColor = UIColor.groupTableViewBackground
        } else {
            imgView_Icon.image = UIImage(named: (obMenu?.icon)!)
            lbl_Name.textColor = UIColor.darkGray
            imgView_Background.backgroundColor = UIColor.white
        }
    }
    
}
