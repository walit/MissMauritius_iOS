//
//  LoginViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 18/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var flagIsShowPassword:Bool? = Bool()
    @IBOutlet weak var btn_ShowPassword: UIButton!
    var flagIsRemember:Bool? = Bool()
    @IBOutlet weak var btn_DontHaveAccount: UIButton!
    @IBOutlet weak var btn_RememberMe: UIButton!
    @IBOutlet weak var btn_Back: UIButton!
    
    
    @IBOutlet weak var tf_Password: UITextField!
    @IBOutlet weak var tf_MobileNo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tf_MobileNo.setLeftPaddingPoints(10.0)
        tf_Password.setLeftPaddingPoints(10.0)
        btn_DontHaveAccount.setDifferentColor(string: "Don't Have An Account? Sign Up", location: 23, length: 7)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        if (self.navigationController?.viewControllers.count)! <= 1 {
            btn_Back.alpha = 0.0
        } else {
            btn_Back.alpha = 1.0
        }
        
        if Preferences?.object(forKey: "isRemember") != nil {
            if (Preferences?.bool(forKey: "isRemember"))! {
                if Preferences?.value(forKey: "mobile") != nil && Preferences?.value(forKey: "password") != nil {
                    btn_RememberMe.setImage(UIImage(named: "check_icon" ), for: .normal)
                    Preferences?.set(true, forKey: "isRemember")
                    flagIsRemember = true
                    tf_MobileNo.text = Preferences?.value(forKey: "mobile") as? String
                    tf_Password.text = Preferences?.value(forKey: "password") as? String
                }
            }
        }

    }
    
    //MARK: Button Actions:
    @IBAction func btn_ShowPassword(_ sender: Any) {
        if !flagIsShowPassword! {
            btn_ShowPassword.setImage(UIImage(named: "blind"), for: UIControl.State.normal)
            tf_Password.isSecureTextEntry = false
        } else {
            btn_ShowPassword.setImage(UIImage(named: "eye"), for: UIControl.State.normal)
            tf_Password.isSecureTextEntry = true
        }
        flagIsShowPassword = !flagIsShowPassword!
    }
    @IBAction func btn_ForgotPassword(_ sender: Any) {
        let vc = MainStoryBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btn_RememberMe(_ sender: Any) {
        if !flagIsRemember! {
            btn_RememberMe.setImage(UIImage(named: "check_icon" ), for: .normal)
            Preferences?.set(true, forKey: "isRemember")
        } else {
            btn_RememberMe.setImage(UIImage(named: "uncheck_icon" ), for: .normal)
            Preferences?.set(false, forKey: "isRemember")
        }
        flagIsRemember = !flagIsRemember!
    }
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_DontHaveAccount(_ sender: Any) {
        let vc = MainStoryBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_SignIn(_ sender: Any) {
        if checkValidations().count > 0 {
            self.showAlertViewWithMessage(checkValidations(), vc: self)
        } else {
            submitLoginRequest()
        }
    }
 
    func checkValidations() -> String {
        var strMsg = String()
        
        if tf_MobileNo?.text?.count == 0 {
            strMsg = ValidationMessages.validationMsgMobileNo
        } else if tf_Password.text?.count == 0 {
            strMsg = ValidationMessages.validationMsgPassword
        }
        return strMsg
    }
    
    func submitLoginRequest() {
        
        let dictP = NSMutableDictionary()
        dictP.setValue(tf_MobileNo.text, forKey: "username")
        dictP.setValue(tf_Password.text, forKey: "password")
        dictP.setValue("2", forKey: "device_type")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.UserManagement.Login, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                self.setFeaturesAfterLogin(dictJson: dictJson["data"] as! NSDictionary)
            }
        }
    }
    
    func setFeaturesAfterLogin(dictJson: NSDictionary) {
        
        obUser?.initWith(dict: dictJson)
        do {
            let archiveUserData = try? NSKeyedArchiver.archivedData(withRootObject: dictJson.mutableCopy(), requiringSecureCoding: true)
            Preferences?.set(archiveUserData , forKey: "UserData")
        } catch let e as Error {
            print("exception = \(e.localizedDescription)")
        }
        
        Preferences?.set(true, forKey: "isLogin")
        Preferences?.set(tf_MobileNo.text, forKey: "mobile")
        Preferences?.set(tf_Password.text, forKey: "password")
        Preferences?.set(dictJson["access_token"] as! String, forKey: "accessToken")
        Preferences?.synchronize()
        
        let vc1 = MainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
        navigationController.viewControllers = [vc1]
        MF.animateViewNavigation(navigationController: navigationController)
        kAppDelegate.window?.rootViewController = navigationController
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (tf_MobileNo.text?.count)! > 0 {
            submitLoginRequest()
        }
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isFirstResponder {
            if (textField.textInputMode?.primaryLanguage == "emoji") || !((textField.textInputMode?.primaryLanguage) != nil) {
                return false
            }
        }
        
        if textField == tf_MobileNo {
            if MF.checkNumberInput(strInput: string) {
                let currentCharacterCount = tf_MobileNo?.text?.count ?? 0
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
