//
//  ContestantModel.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 21/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class ContestantModel: NSObject {
    var contestantId:Int? = Int()
    var fullName:String? = String()
    var image:String? = String()
    var isVote:Int? = Int()
    
    override init() { }
    
    func initWith(dict: NSDictionary?) {
        if let contId = dict?["contestant_id"] as? Int {
            self.contestantId = contId
        } else if let strContId = dict?["contestant_id"] as? String {
            self.contestantId = Int(strContId)
        }
        
        self.fullName = dict?["full_name"] as? String
        self.image = dict?["image"] as? String
        if let vote = dict?["is_vote"] as? Int {
            self.isVote = vote
        } else if let strVote = dict?["is_vote"] as? String {
            self.isVote = Int(strVote)
        }
    }
}
