//
//  CommitteeModel.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 14/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class CommitteeModel: NSObject {
    var name:String? = String()
    var about:String? = String()
    var detail:String? = String()
    
    func initWith(dict: NSDictionary?) {
        self.name = dict?["full_name"] as? String
        self.about = dict?["about"] as? String
        self.detail = dict?["detail"] as? String
    }
    
}
