//
//  CollectionHeaderClass.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 26/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class CollectionHeaderClass: UICollectionReusableView {
    
    @IBOutlet weak var imgView_Banner: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.purple
        
        // Customize here
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setBannerImage(imgUrl: String) {
        
    }
    
}
