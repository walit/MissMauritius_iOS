//
//  PastWinnerModel.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 16/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class PastWinnerModel: NSObject {
    var fullName:String? = String()
    var height:String? = String()
    var qualification:String? = String()
    var age:String? = String()
    var occupation:String? = String()
    var talent:String? = String()
    var sportsPractice:String? = String()
    var ambition:String? = String()
    var imageUrl:String? = String()
    
    override init() {   }
    
    func initWith(dict: NSDictionary?) {
        self.fullName = dict?["full_name"] as? String
        self.height = dict?["height"] as? String
        self.qualification = dict?["qualification"] as? String
        self.age = dict?["age"] as? String
        self.occupation = dict?["occupation"] as? String
        self.talent = dict?["talent"] as? String
        self.sportsPractice = dict?["sport_practised"] as? String
        self.ambition = dict?["ambition"] as? String
        self.imageUrl = dict?["image"] as? String
    }
}
