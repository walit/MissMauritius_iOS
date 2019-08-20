//
//  GalleryModel.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 14/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class GalleryModel: NSObject {
    var image:String? = String()
    var name:String? = String()
    var gallery: NSArray? = NSArray()
    func initWith(dict: NSDictionary?) {
        self.name = dict?["full_name"] as? String
        self.image = dict?["image"] as? String
        self.gallery = dict?["gallery"] as? NSArray
    }
    
}
