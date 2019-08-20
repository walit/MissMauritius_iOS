//
//  ChangePasswordViewController.swift
//  Audit
//
//  Created by Rupesh Chhabra on 25/10/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    var strMobileNo = String()
    //MARK: Outlets and Variables
    @IBOutlet weak var tf_ConfirmPassword: UITextField!
    @IBOutlet weak var tf_NewPassword: UITextField!
    @IBOutlet weak var tf_OldPassword: UITextField!
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tf_NewPassword.setLeftPaddingPoints(5.0)
        tf_ConfirmPassword.setLeftPaddingPoints(5.0)
        // Do any additional setup after loading the view.
    }
    
    //MARK: Button Actions:
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Submit(_ sender: Any) {
        if checkValidations().count > 0 {
            self.showAlertViewWithMessage(checkValidations(), vc: self)
        } else {
            submitChangePasswordRequest()
        }
    }
   
    //MARK: Supporting Functions:
    func checkValidations() -> String {
        var strMsg = String()
        if tf_NewPassword?.text?.count == 0 {
            strMsg = ValidationMessages.validationMsgNewPswd
        } else if (tf_NewPassword?.text?.count)! < ValidationConstants.PasswordLength {
            strMsg = ValidationMessages.validationMsgPswdLength
        } else if tf_ConfirmPassword?.text != tf_NewPassword?.text {
            strMsg = ValidationMessages.validationMsgPswdMatch
        }
        return strMsg
    }
    
    func submitChangePasswordRequest() {
        let dictP = NSMutableDictionary()
        dictP.setValue(strMobileNo, forKey: "username")
        dictP.setValue(tf_NewPassword?.text, forKey: "password")
        
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.UserManagement.ResetPassword, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                self.showAlertViewWithDuration(dictJson["message"] as! String, vc: self)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
                    let vc = MainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    navigationController.viewControllers.append(vc)
                    MF.animateViewNavigation(navigationController: navigationController)
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        
    }
}

