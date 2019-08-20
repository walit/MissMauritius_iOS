//
//  ForgotPassword_VC.swift
//  Audit
//
//  Created by Mac on 10/9/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    //MARK: Variable & Outlets
    
    @IBOutlet weak var tf_Mobile: DesignableUITextField!

    @IBAction func btn_Submit(_ sender: Any) {
        if (checkValidations().count) > 0 {
            self.showAlertViewWithMessage(checkValidations(), vc: self)
        } else {
            tf_Mobile.resignFirstResponder()
            submitForgotPasswordRequest()
        }
    }
    
    @IBOutlet weak var tf_email: DesignableUITextField!
    
    
    //MARK: View Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
      //  delegate = self
        tf_Mobile.setLeftPaddingPoints(5.0)
        // Create a padding view for padding on left
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: Helper Methods validations
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
       // kAppDelegate.currentViewController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Supporting Functions:
    func checkValidations() -> String {
        var errorMessage = String()
        if tf_Mobile.text?.count == 0 {
            errorMessage = "Please enter mobile no"
        }
        return errorMessage
    }
    
    func submitForgotPasswordRequest() {
        let dictP = NSMutableDictionary()
        dictP.setValue(tf_Mobile.text, forKey: "username")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.UserManagement.ForgotPassword, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                let vc = MainStoryBoard.instantiateViewController(withIdentifier: "VerifyOTPViewController") as! VerifyOTPViewController
                vc.strMobile = self.tf_Mobile.text!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isFirstResponder {
            if (textField.textInputMode?.primaryLanguage == "emoji") || !((textField.textInputMode?.primaryLanguage) != nil) {
                return false
            }
        }
        
        if textField == tf_Mobile {
            if MF.checkNumberInput(strInput: string) {
                let currentCharacterCount = tf_Mobile?.text?.count ?? 0
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
