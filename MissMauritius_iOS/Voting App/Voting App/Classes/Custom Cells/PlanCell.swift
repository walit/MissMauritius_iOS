//
//  PlanCell.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 24/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

protocol PlanDelegate {
    func buyVote(index: Int)
}

class PlanCell: UICollectionViewCell {
    var delegate: PlanDelegate?
    var index = Int()
    
    @IBOutlet weak var imgViewHeightConstraint: NSLayoutConstraint!
    @IBAction func btn_Buy(_ sender: Any) {
        delegate?.buyVote(index: index)
    }
    @IBOutlet weak var btn_Buy: UIButton!
    @IBOutlet weak var imgView_Plan: UIImageView!
    @IBOutlet weak var lbl_PlanPrice: UILabel!
    
    
    func setPlanData(ob: PlanModel?) {
        lbl_PlanPrice.text = ob?.planPrice
        imgView_Plan.image = UIImage(named: ob!.planImage!)
        if DeviceType.IS_IPHONE_5 {
            imgViewHeightConstraint.constant = 70.0
        }
    }
    
    func setVotePlanData(ob: PlanModel?) {
        lbl_PlanPrice.text = String(format: "Purchase for %@ MUR", ob!.votePrice!)
        imgView_Plan.image = UIImage(named: String(format: "thumb-%d+", ob!.totalVotes!))
        if DeviceType.IS_IPHONE_5 {
            imgViewHeightConstraint.constant = 60.0
        }
    }
    
}
