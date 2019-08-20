//
//  GalleryViewCell.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 14/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class GalleryViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView_User: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    
    func setGalleryData(obGal: GalleryModel?) {
        lbl_Name.text = obGal?.name
        imgView_User.sd_setImage(with: URL(string: (obGal?.image!)!), placeholderImage: UIImage.init(named: "user_placeholde"))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.imgView_User.image != nil {
                self.imgView_User.image = MF.cropBottomImage(image: self.imgView_User.image!)
            }
        }
    }
    
    func setPastWinnerData(obGal: PastWinnerModel?) {
        lbl_Name.text = obGal?.fullName
        imgView_User.sd_setImage(with: URL(string: (obGal?.imageUrl!)!), placeholderImage: UIImage())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.imgView_User.image != nil {
             //   self.imgView_User.image = MF.cropBottomImage(image: self.imgView_User.image!)
            }
        }
    }
    
}
