//
//  FourthTVCell.swift
//  Hooz App
//
//  Created by Parkhya Solutions on 10/27/16.
//  Copyright © 2016 iOS. All rights reserved.
//
import UIKit

class CountryPickerTVCell: UITableViewCell {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var imgCountry: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
