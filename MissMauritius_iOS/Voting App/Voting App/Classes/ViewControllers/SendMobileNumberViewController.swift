//
//  SendMobileNumberViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 27/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class SendMobileNumberViewController: UIViewController {
    
    @IBAction func btn_CloseOTPView(_ sender: Any) {
        view_Otp.alpha = 0.0
    }
    var timer:Timer? = Timer()
    var counter = Int()
    var obPlan = PlanModel()
    @IBOutlet weak var tf_Otp: DesignableUITextField!
    @IBOutlet var view_Otp: UIView!
    
    @IBOutlet weak var btn_ResendOTP: UIButton!
    @IBOutlet weak var lbl_Timer: UILabel!
    
    @IBOutlet weak var tf_MobileNumber: DesignableUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view_Otp.frame = self.view.bounds
        self.view.addSubview(view_Otp)
        view_Otp.alpha = 0.0
        
        tf_Otp.setLeftPaddingPoints(5.0)
        tf_MobileNumber.setLeftPaddingPoints(5.0)
        btn_ResendOTP.alpha = 0.0
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    
    func checkValidations() -> String {
        var strMsg = String()
        if tf_MobileNumber.text?.count == 0 {
            strMsg = "Please enter mobile number"
        }
        return strMsg
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Submit(_ sender: Any) {
        if checkValidations().count > 0 {
            self.showAlertViewWithMessage(checkValidations(), vc: self)
        } else {
            submitOtpToWallitPhoneRequest()
        }
    }
    
    @IBAction func btn_VerifyOtp(_ sender: Any) {
        if tf_Otp.text?.count == 0 {
            self.showAlertViewWithMessage("Please enter otp", vc: self)
        } else {
            verifyOtpRequest()
        }
    }
    
    @IBAction func btn_ResendOTP(_ sender: Any) {
        self.btn_Submit(self)
    }
    
    
    
    func submitOtpToWallitPhoneRequest() {
        let dictP = NSMutableDictionary()
        dictP.setValue(tf_MobileNumber.text, forKey: "phone")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.OTPWallitPhone, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                self.counter = 60
                self.btn_ResendOTP.alpha = 0.0
                self.lbl_Timer.alpha = 1.0
                self.view_Otp.alpha = 1.0
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
            }
        }
    }
    
    @objc func timerAction() {
        counter -= 1
        lbl_Timer.text = String(format: "Your OTP will received in %d seconds", counter)
        if counter == 0 {
            timer?.invalidate()
            btn_ResendOTP.alpha = 1.0
            lbl_Timer.alpha = 0.0
        }
    }
    
    func verifyOtpRequest() {
        let dictP = NSMutableDictionary()
        dictP.setValue(tf_MobileNumber.text, forKey: "phone")
        dictP.setValue(tf_Otp.text, forKey: "otp")
        dictP.setValue(obPlan.votePriceId, forKey: "voteprice_id")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.Payments.VerifyWalletOTP, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                let vc = MainStoryBoard.instantiateViewController(withIdentifier: "TransactionStatusViewController") as! TransactionStatusViewController
                vc.strStatus = "success"
                vc.obPlan = self.obPlan
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

extension SendMobileNumberViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isFirstResponder {
            if (textField.textInputMode?.primaryLanguage == "emoji") || !((textField.textInputMode?.primaryLanguage) != nil) {
                return false
            }
        }
        
        if textField == tf_MobileNumber {
            if MF.checkNumberInput(strInput: string) {
                let currentCharacterCount = tf_MobileNumber?.text?.count ?? 0
                let newLength = currentCharacterCount + string.count - range.length
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                return newLength <= ValidationConstants.MaxMobileNumberLength
            } else {
                return false
            }
        }
        return true
    }
}
