//
//  MenuModel.swift
//  Individual App
//
//  Created by Rupesh Chhabra on 23/04/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class MenuModel: NSObject {
    var name:String? = String()
    var icon:String? = String()
    var selectedIcon:String? = String()
    var isSelected:Int? = Int()
    
    override init() { }
    
    func initWith(name:String?, icon:String?)/*, isSelected:Int?, selectedIcon:String?)*/ {
        self.name = name
        self.icon = icon
        //self.isSelected = isSelected
        //self.selectedIcon = selectedIcon
    }
}
