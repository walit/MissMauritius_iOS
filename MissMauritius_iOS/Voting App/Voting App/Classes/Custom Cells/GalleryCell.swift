//
//  GalleryCell.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 01/07/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView_User: UIImageView!
    
    func setUserImage(imgUrl: String) {
        imgView_User.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage())
    }
    
}
