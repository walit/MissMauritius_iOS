//
//  PlanModel.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 24/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class PlanModel: NSObject {
    var totalVotes:Int? = Int()
    var title:String? = String()
    var votePrice:String? = String()
    var votePriceId:Int? = Int()
    
    
    var planImage:String? = String()
    var planPrice:String? = String()
    var planBuy:String? = String()
    
    override init() { }
    
    func initWith(name: String?, icon:String?) {
        planPrice = name
        planImage = icon
    }
    
    func initWith(dict: NSDictionary?) {
        self.title = dict?["title"] as? String
        if let totalV = dict?["total_vote"] as? Int {
            self.totalVotes = totalV
        } else if let strTV = dict?["total_vote"] as? String {
            self.totalVotes = Int(strTV)
        }
        /*if let vPrice = dict?["vote_price"] as? Int {
            self.votePrice = vPrice
        } else if let strVP = dict?["vote_price"] as? String { */
        if let strVP = dict?["vote_price"] as? String {
            self.votePrice = strVP
        }
        /*} else if let voteP = dict?["vote_price"] as? Float {
            self.votePrice = Int(voteP)
        } */
        print("self.votePrice = \(self.votePrice)")
        
        if let id = dict?["voteprice_id"] as? Int {
            self.votePriceId = id
        } else if let strId = dict?["voteprice_id"] as? String {
            self.votePriceId = Int(strId)
        }
    }
    
}
