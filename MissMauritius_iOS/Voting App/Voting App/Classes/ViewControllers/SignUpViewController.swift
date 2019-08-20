//
//  SignUpViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 19/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var tfHeightConstraint: NSLayoutConstraint!
    var selectedCountry: Country!
    var Number:String!
    var strDialCode = String()
    var strCountryCode = String()
    var arrCountries = [[String: String]]()
    
    @IBAction func btn_CloseOTPView(_ sender: Any) {
        view_Otp.alpha = 0.0
        tf_Otp.text = ""
    }
    @IBAction func btn_VerifyOtp(_ sender: Any) {
        if tf_Otp.text?.count == 0 {
            self.showAlertViewWithMessage("Please enter otp", vc: self)
        } else {
            verifyOtpRequest()
        }
    }
    @IBOutlet weak var tf_Otp: DesignableUITextField!
    @IBOutlet var view_Otp: UIView!
    
    @IBOutlet weak var view_Content: UIView!
    @IBOutlet weak var btn_SignUp: UIButton!
    var flagIsShowPassword:Bool? = Bool()
    @IBOutlet weak var btn_SelectCountry: UIButton!
    @IBOutlet weak var tf_FirstName: UITextField!
    @IBOutlet weak var tf_Password: UITextField!
    @IBOutlet weak var tf_Email: UITextField!
    @IBOutlet weak var tf_MobileNo: UITextField!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var btn_AlreadyMember: UIButton!
    @IBOutlet weak var btn_ShowPassword: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DeviceType.IS_IPHONE_5 {
            tfHeightConstraint.constant = 38.0
        }
        
        view_Otp.frame = self.view.bounds
        self.view.addSubview(view_Otp)
        view_Otp.alpha = 0.0
        
        loadCountriesData()
        btn_AlreadyMember.setDifferentColor(string: "Already Member Login here", location: 15, length: 5)
        tf_FirstName.setLeftPaddingPoints(10.0)
      //  tf_FirstName.setRightPaddingPoints(30.0)
        tf_Otp.setLeftPaddingPoints(5.0)
        
        tf_Email.setLeftPaddingPoints(10.0)
        tf_Email.setRightPaddingPoints(10.0)
        
        tf_MobileNo.setLeftPaddingPoints(btn_SelectCountry.frame.size.width + 5)
        tf_MobileNo.setRightPaddingPoints(10.0)
        
        tf_Password.setLeftPaddingPoints(10.0)
        tf_Password.setRightPaddingPoints(10.0)
        
        let locale = Locale.current
       
       /// This will set the country code data according to local region
        for obCountries in arrCountries {
            if obCountries["code"] == locale.regionCode {
                strCountryCode = obCountries["code"]!
                strDialCode = obCountries["dial_code"]!
                let strCC = String(format: "(%@) %@", strCountryCode, strDialCode)
                btn_SelectCountry.setTitle(strCC, for: UIControl.State.normal)
                btn_SelectCountry.setImage(UIImage(named: strCountryCode), for: UIControl.State.normal)
                break
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        view_Content.frame = CGRect(x: 0, y: 0, width: scrlView.frame.size.width, height: btn_SignUp.frame.origin.y + btn_SignUp.frame.size.height + 20)
        scrlView.frame = CGRect(x: scrlView.frame.origin.x, y: scrlView.frame.origin.y , width: scrlView.frame.size.width, height: view_Content.frame.size.height)
        scrlView.contentSize = CGSize(width: scrlView.frame.size.width, height: view_Content.frame.size.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK: BUtton Actions:
    
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
    
   @IBAction func btn_Back(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_SignUp(_ sender: Any) {
        if checkValidations().count > 0 {
            self.showAlertViewWithMessage(checkValidations(), vc: self)
        } else {
            self.submitSignUpRequest()
        }
    }
    
    @IBAction func btn_SelectCountry(_ sender: Any) {
        self.performSegue(withIdentifier: "countryScreen", sender: self)
    }
    @IBAction func btn_AlreadyMember(_ sender: Any) {
        let vc1 = MainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
        navigationController.viewControllers = [vc1]
        kAppDelegate.window?.rootViewController = navigationController
    }
    
    //MARK: Supporting FUnctions:
    
    func loadCountriesData() {
        let data = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "countries", ofType: "json")!))
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            arrCountries = parsedObject as! [[String : String]]
        }catch{
            print("not able to parse")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "countryScreen" {
            if let control = segue.destination as? UINavigationController {
                if let contrl = control.topViewController as? SRCountryPickerController {
                    contrl.countryDelegate = self
                }
            }
        }
    }
    
    func checkValidations() -> String {
        var strMsg = String()
        
        if tf_FirstName.text?.count == 0 {
            strMsg = ValidationMessages.validationFullName
        } else if tf_Email.text?.count == 0 {
            strMsg = ValidationMessages.validationMsgEmail
        } else if Validation.isValidEmail(testStr: tf_Email.text!) == false {
            strMsg = ValidationMessages.validationMsgValidEmail
        } else if tf_MobileNo.text?.count == 0 {
            strMsg = ValidationMessages.validationMsgMobileNo
        } else if tf_Password.text?.count == 0 {
            strMsg = ValidationMessages.validationMsgPassword
        } else if tf_Password.text!.count < ValidationConstants.PasswordLength {
            strMsg = ValidationMessages.validationMsgPswdLength
        }
        return strMsg
    }
    
    func submitSignUpRequest() {
        
        let dictP = NSMutableDictionary()
        dictP.setValue(tf_FirstName.text, forKey: "first_name")
        dictP.setValue("", forKey: "last_name")
        dictP.setValue(tf_Email.text, forKey: "email")
        dictP.setValue(tf_MobileNo.text, forKey: "phone")
        dictP.setValue(strCountryCode, forKey: "country_id")
        dictP.setValue(strDialCode, forKey: "phone_code")
        dictP.setValue(tf_Password.text, forKey: "password")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.UserManagement.SignUp, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                self.view_Otp.alpha = 1.0
            }
        }
    }
    
    func verifyOtpRequest() {
         let dictP = NSMutableDictionary()
         dictP.setValue(tf_MobileNo.text, forKey: "phone")
        dictP.setValue(tf_Otp.text, forKey: "otp")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.UserManagement.VerifyOTP, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                let vc1 = MainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
                navigationController.viewControllers = [vc1]
                kAppDelegate.window?.rootViewController = navigationController
            }
        }
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (tf_MobileNo.text?.count)! > 0 {
            
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

extension SignUpViewController: CountrySelectedDelegate {
    
    func SRcountrySelected(countrySelected country: Country) {
        self.selectedCountry = country
        strCountryCode = self.selectedCountry .country_code
        strDialCode = self.selectedCountry .dial_code
        let strCC = String(format: "(%@) %@", strCountryCode, strDialCode)
        
        btn_SelectCountry.setTitle(strCC, for: UIControl.State.normal)
        let img = String(format: "%@.png", self.selectedCountry.country_code)
        btn_SelectCountry.setImage(UIImage(named: self.selectedCountry.country_code), for: UIControl.State.normal)
    }
    
}
