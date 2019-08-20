//
//  ContactUsViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 02/07/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {
    @IBOutlet weak var view_Content: UIView!
    @IBOutlet weak var tf_Name: DesignableUITextField!
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var tv_Comment: UITextView!
    @IBOutlet weak var tf_Mobile: DesignableUITextField!
    @IBOutlet weak var tf_Email: DesignableUITextField!
    @IBOutlet weak var tfHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrlView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if DeviceType.IS_IPHONE_5 {
            tfHeightConstraint.constant = 38.0
        }
        tf_Name.setLeftPaddingPoints(5.0)
        tf_Mobile.setLeftPaddingPoints(5.0)
        tf_Email.setLeftPaddingPoints(5.0)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        view_Content.frame = CGRect(x: 0, y: 0, width: scrlView.frame.size.width, height: btn_Submit.frame.origin.y + btn_Submit.frame.size.height + 90)
        scrlView.contentSize = CGSize(width: scrlView.frame.size.width, height: view_Content.frame.size.height)
    }
    
    @IBAction func btn_Submit(_ sender: Any) {
        if checkValidations().count > 0 {
            showAlertViewWithMessage(checkValidations(), vc: self)
        } else {
            submitContactUsRequest()
        }
    }

    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkValidations() -> String {
        var strMsg = String()
        if tf_Name.text?.count == 0 {
            strMsg = "Please enter your name"
        } else if tf_Email.text?.count == 0 {
            strMsg = "Please enter email"
        } else if Validation.isValidEmail(testStr: tf_Email.text!) == false {
            strMsg = ValidationMessages.validationMsgValidEmail
        } else if tf_Mobile.text?.count == 0 {
            strMsg = ValidationMessages.validationMsgMobileNo
        } else if tv_Comment.text.count == 0 {
            strMsg = "Please enter your comments"
        }
        return strMsg
    }
    
    func submitContactUsRequest() {
        let dictP = NSMutableDictionary()
        dictP.setValue(tf_Name.text, forKey: "full_name")
        dictP.setValue(tf_Email.text, forKey: "email")
        dictP.setValue(tf_Mobile.text, forKey: "phone")
        dictP.setValue(tv_Comment.text, forKey: "comments")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.Common.AddComments , methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                self.showAlertViewWithDuration(dictJson["message"] as! String, vc: self)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
                    let vc = MainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    navigationController.viewControllers.append(vc)
                    MF.animateViewNavigation(navigationController: navigationController)
                }
                
               
            }
        }
        
    }
    
}

extension ContactUsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (tf_Mobile.text?.count)! > 0 {
            
        }
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

extension ContactUsViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Your comments" {
            textView.textColor = UIColor.white
            textView.text = ""
        }
        tv_Comment.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.textColor = UIColor.white
            textView.text = "YOur comments"
        }
    }
    
    func textViewDidChange(_ textView: UITextView) { }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.autocorrectionType = .no
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        let currentCharacterCount = tv_Comment?.text?.count ?? 0
        let newLength = currentCharacterCount + text.count - range.length
        if(newLength <= ValidationConstants.MaxDescriptionLimit) {
            return true
        } else {
            return false
        }
    }
}
