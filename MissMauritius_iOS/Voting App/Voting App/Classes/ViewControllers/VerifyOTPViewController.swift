//
//  VerifyOTPViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 01/07/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class VerifyOTPViewController: UIViewController {
    @IBOutlet weak var btn_ResendOTP: UIButton!
    @IBOutlet weak var lbl_Timer: UILabel!
    @IBOutlet weak var lbl_Msg: UILabel!
    
    var timer:Timer? = Timer()
    var counter = Int()
    var strMobile = String()
    
     @IBOutlet weak var tf_Otp: DesignableUITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tf_Otp.setLeftPaddingPoints(5.0)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        lbl_Msg.text = String(format: "We have send you SMS/Email with 4 digit Verification code (OTP) on %@", strMobile)
    }
    
    // MARK: - Navigation
    @IBAction func btn_VerifyOtp(_ sender: Any) {
        if tf_Otp.text?.count == 0 {
            self.showAlertViewWithMessage("Please enter otp", vc: self)
        } else {
            verifyOtpRequest()
        }
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_ResendOTP(_ sender: Any) {
        submitResendOTPRequest()  
    }
    
    func verifyOtpRequest() {
        let dictP = NSMutableDictionary()
        dictP.setValue(strMobile, forKey: "username")
        dictP.setValue(tf_Otp.text, forKey: "otp")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.UserManagement.VerifyOTPForgot, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                let vc1 = MainStoryBoard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
                vc1.strMobileNo = self.strMobile
               self.navigationController?.pushViewController(vc1, animated: true)
            }
        }
    }
    
    func submitResendOTPRequest() {
        let dictP = NSMutableDictionary()
        dictP.setValue(strMobile, forKey: "username")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.UserManagement.ForgotPassword, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                self.counter = 10
                self.btn_ResendOTP.alpha = 0.0
                self.lbl_Timer.alpha = 1.0
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
}

extension VerifyOTPViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isFirstResponder {
            if (textField.textInputMode?.primaryLanguage == "emoji") || !((textField.textInputMode?.primaryLanguage) != nil) {
                return false
            }
        }
        
        if textField == tf_Otp {
            if MF.checkNumberInput(strInput: string) {
                let currentCharacterCount = tf_Otp?.text?.count ?? 0
                let newLength = currentCharacterCount + string.count - range.length
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                return newLength <= 4
            } else {
                return false
            }
        }
        return true
    }
}
