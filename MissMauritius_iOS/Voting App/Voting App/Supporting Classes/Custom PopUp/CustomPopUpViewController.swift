//
//  CustomPopUpViewController.swift
//  Audit
//
//  Created by Rupesh Chhabra on 26/12/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
@objc protocol PopUpDelegate {
    
    @objc optional func actionOnYes()
    @objc optional func actionOnNo()
    @objc optional func actionOnOk()
}
class CustomPopUpViewController: UIViewController {

    @IBOutlet weak var viewYesNo: UIStackView!
    var popUpDelegate: PopUpDelegate?
    @IBOutlet weak var btn_Ok: UIButton!
    @IBOutlet weak var viewOk: UIStackView!
    @IBOutlet weak var spacing_okbtn_constraint: NSLayoutConstraint!
    @IBOutlet weak var btn_No: UIButton!
    @IBOutlet weak var spacing_Yesno_constraint: NSLayoutConstraint!
    @IBOutlet weak var btn_Yes: UIButton!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewYesNo.alpha = 0.0
        viewOk.alpha = 0.0
   //     btn_Ok.alpha = 0.0
        
        // Do any additional setup after loading the view.
   
    }
    
    // MARK: - Navigation

    
    @IBAction func btn_No(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        popUpDelegate?.actionOnNo!()
    }
    @IBAction func btn_Yes(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        popUpDelegate?.actionOnYes!()
    }
    @IBAction func btn_Ok(_ sender: Any) {
        self.view.removeFromSuperview()
        self.dismiss(animated: false, completion: nil)
        popUpDelegate?.actionOnOk!()
    }
    
    func ShowPopUpWithOk(title: String , message:String) {
        lbl_Title.text = title
        lbl_Message.text = message
        //btn_Ok.alpha = 1.0
        viewOk.alpha = 1.0
        spacing_okbtn_constraint.constant = 10
        spacing_Yesno_constraint.constant = 10
    }
    
    func ShowPopUpWithOkAction(title: String , message:String, delegate: UIViewController) {
        lbl_Title.text = title
        lbl_Message.text = message
        popUpDelegate = (delegate as! PopUpDelegate)
        viewOk.alpha = 1.0
        spacing_okbtn_constraint.constant = 10
        spacing_Yesno_constraint.constant = 10
    }
    
    func ShowPopUpWithAction(title: String , message:String, delegate: UIViewController) {
        lbl_Title.text = title
        lbl_Message.text = message
        popUpDelegate = (delegate as! PopUpDelegate)
        viewYesNo.alpha = 1.0
        spacing_okbtn_constraint.constant = 10
        spacing_Yesno_constraint.constant = 10
    }
    
    func ShowPopUpToast(title: String, message:String, delegate: UIViewController) {
        lbl_Title.text = title
        lbl_Message.text = message
        viewYesNo.alpha = 0.0
        spacing_okbtn_constraint.constant = 0
        spacing_Yesno_constraint.constant = 0
    }
    
}
