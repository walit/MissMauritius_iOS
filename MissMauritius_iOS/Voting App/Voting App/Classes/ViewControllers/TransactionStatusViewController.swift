//
//  TransactionStatusViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 28/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class TransactionStatusViewController: UIViewController {
    var obPlan = PlanModel()
    @IBOutlet weak var btn_Redirect: UIButton!
    @IBOutlet weak var lbl_Status: UILabel!
    @IBOutlet weak var lbl_VoteStatus: UILabel!
    var strStatus = String()
    @IBOutlet weak var lblHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if strStatus == "fail" {
            lbl_Status.text = "FAILED"
            lbl_Status.textColor = UIColor.red
            btn_Redirect.setTitle("RETRY", for: UIControl.State.normal)
            lbl_VoteStatus.alpha = 0.0
            lblHeightConstraint.constant = 0.0
        } else if strStatus == "success" {
            lbl_Status.text = "SUCCESSFULLY"
            lbl_Status.textColor = CustomColors.themeColorYellow
            btn_Redirect.setTitle("OK", for: UIControl.State.normal)
            lbl_VoteStatus.alpha = 1.0
            lblHeightConstraint.constant = 28.0
            print("obPlan.totalVotes! = \(obPlan.totalVotes!)")
            
            lbl_VoteStatus.text = String(format: "You have added %d Votes", obPlan.totalVotes!)
        }
    }
    
    @IBAction func btn_Redirect(_ sender: Any) {
        if strStatus == "fail" {
            self.navigationController?.popViewController(animated: true)
        } else if strStatus == "success" {
            let vc1 = MainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
            navigationController.viewControllers = [vc1]
            kAppDelegate.window?.rootViewController = navigationController
        }
    }
    
}
