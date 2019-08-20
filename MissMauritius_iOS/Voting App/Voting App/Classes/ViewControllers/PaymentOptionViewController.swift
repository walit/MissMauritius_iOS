//
//  PaymentOptionViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 26/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class PaymentOptionViewController: UIViewController {
var intPayType = Int()
    var obPlan = PlanModel()
    @IBOutlet weak var btn_PayOnline: UIButton!
    @IBOutlet weak var btn_Wallet: UIButton!
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func btn_PayOnline(_ sender: Any) {
       intPayType = 2
        btn_PayOnline.setImage(UIImage(named: "checked"), for: UIControl.State.normal)
        
        btn_Wallet.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
    }
    
    @IBAction func btn_Wallet(_ sender: Any) {
       intPayType = 1
        btn_PayOnline.setImage(UIImage(named: "uncheck"), for: UIControl.State.normal)
        btn_Wallet.setImage(UIImage(named: "checked"), for: UIControl.State.normal)
    }
    
    @IBAction func btn_Proceed(_ sender: Any) {
        if intPayType == 1 {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "SendMobileNumberViewController") as! SendMobileNumberViewController
            vc.obPlan = obPlan
            self.navigationController?.pushViewController(vc, animated: true)
        } else if intPayType == 2 {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "CardPaymentViewController") as! CardPaymentViewController
            vc.obPlan = obPlan
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
