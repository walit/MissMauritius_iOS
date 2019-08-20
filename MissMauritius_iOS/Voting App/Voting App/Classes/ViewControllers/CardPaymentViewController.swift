//
//  CardPaymentViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 27/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class CardPaymentViewController: UIViewController {
    
    @IBOutlet weak var imgTick3: UIImageView!
    @IBOutlet weak var imgTick2: UIImageView!
    @IBOutlet weak var imgTick1: UIImageView!
    
    var strCardType = String()
    var obPlan = PlanModel()
    var payRequestId = String()
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btn_PayNow(_ sender: Any) {
        if checkValidations().count > 0 {
            self.showAlertViewWithMessage(checkValidations(), vc: self)
        } else {
            submitCardPaymentRequest()
        }
    }
    @IBOutlet weak var tf_CVV: DesignableUITextField!
    @IBOutlet weak var tf_Year: DesignableUITextField!
    @IBOutlet weak var tf_MM: DesignableUITextField!
    @IBOutlet weak var tf_CardNumber: DesignableUITextField!
    @IBOutlet weak var tf_CardHolderName: DesignableUITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        strCardType = "VISA"
        // Do any additional setup after loading the view.
    }
    
    //MARK: Supporting Functions
    
    func checkValidations() -> String {
        var strMsg = String()
        if tf_CardHolderName.text?.count == 0 {
            strMsg = "Please enter card holder name"
        } else if tf_CardNumber.text?.count == 0 {
            strMsg = "Please enter card number"
        } else if tf_CardNumber.text!.count < 16 {
            strMsg = "Please enter valid card number"
        } else if tf_MM.text?.count == 0 {
            strMsg = "Please enter month"
        } else if tf_Year.text?.count == 0 {
            strMsg = "Please enter expiry year"
        } else if tf_CVV.text?.count == 0 {
            strMsg = "Please enter CVV"
        }
        return strMsg
    }
    
    func submitCardPaymentRequest() {
        /*{ \n\t\"voteprice_id\":\"1\",\n    \"card_type\":\"VISA\",\n    \"card_holder_name\":\"test\",\n    \"card_number\":\"4000000000000002\",\n    \"card_expiry_month\":\"03\",\n    \"card_expiry_year\":\"2020\",\n    \"cvv\":\"123\"\n}" */
        
        let dictP = NSMutableDictionary()
        dictP.setValue(obPlan.votePriceId, forKey: "voteprice_id")
        dictP.setValue(strCardType, forKey: "card_type")
        dictP.setValue(tf_CardHolderName.text, forKey: "card_holder_name")
        dictP.setValue(tf_CardNumber.text, forKey: "card_number")
        dictP.setValue(tf_MM.text, forKey: "card_expiry_month")
        dictP.setValue(tf_Year.text, forKey: "card_expiry_year")
        dictP.setValue(tf_CVV.text, forKey: "cvv")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.Payments.BuyVote, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                let dictData = dictJson["data"] as! NSDictionary
                self.payRequestId = dictData["id"] as! String
                let dictRedirect = (dictJson["data"] as! NSDictionary)["redirect"] as! NSDictionary
                let url = dictRedirect["url"] as! String
                let arrParams = dictRedirect["parameters"] as! NSArray
                var strPostData = String()
                var strTermUrl = String()
                var strPaReq = String()
                var strMD = String()
                var strConnector = String()
                
            /*    for i in 0..<arrParams.count {
                    
                   
                    if (arrParams[i] as! NSDictionary)["name"] as? String == "TermUrl" {
                        strTermUrl.append(contentsOf: (arrParams[i] as! NSDictionary)["value"] as! String)
                    }
                    
                    if (arrParams[i] as! NSDictionary)["name"] as? String == "PaReq" {
                        strPaReq.append(contentsOf: "&")
                        strPaReq.append((arrParams[i] as! NSDictionary)["name"] as! String)
                        strPaReq.append(contentsOf: "=")
                        strPaReq.append((arrParams[i] as! NSDictionary)["value"] as! String)
                    }
                    
                    if (arrParams[i] as! NSDictionary)["name"] as? String == "MD" {
                        strMD.append(contentsOf: "&")
                        strMD.append((arrParams[i] as! NSDictionary)["name"] as! String)
                        strMD.append(contentsOf: "=")
                        strMD.append((arrParams[i] as! NSDictionary)["value"] as! String)
                    }
                    
                    if (arrParams[i] as! NSDictionary)["name"] as? String == "connector" {
                        strConnector.append(contentsOf: "&")
                        strConnector.append((arrParams[i] as! NSDictionary)["name"] as! String)
                        strConnector.append(contentsOf: "=")
                        strConnector.append((arrParams[i] as! NSDictionary)["value"] as! String)
                    }
                    
                   
                    
                } */
                
                strPostData.append(strTermUrl)
                strPostData.append(strMD)
                strPostData.append(strPaReq)
                strPostData.append(strConnector)
                
                print("strPostData = \(strPostData)")
                
                let vc = MainStoryBoard.instantiateViewController(withIdentifier: "PaymentResponseViewController") as! PaymentResponseViewController
                vc.url = url
                if let value = dictData.value(forKey: "id") as? String {
                    vc.payRequestId = value
                }
                print("self.getBodyData(parameters: arrParams) = \(self.getBodyData(parameters: arrParams))")
                vc.obPlan = self.obPlan
                vc.strPostData = self.getBodyData(parameters: arrParams)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    func getBodyData(parameters: NSArray) -> String{
        var body = ""
        
        for i in 0..<parameters.count {
            let dict = parameters[i] as! NSDictionary
            let paramName = dict["name"] as! String
            if body == "" {
                
            } else {
                body += "&"
            }
             body += "\(paramName)="
            if let paramValue = dict["value"] as? String {
                 body += "\(paramValue)"
            }
        }
        if let value = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            print(value)
            return value
        }else{
            print(body)
            return body;
        }
        
    }
    
    @IBAction func btn_Visa(_ sender: Any) {
        strCardType = "VISA"
        imgTick1.image = UIImage(named: "tick_icon")
        imgTick2.image = UIImage()
        imgTick3.image = UIImage()
    }
    
    @IBAction func btn_Master(_ sender: Any) {
        strCardType = "MASTERCARD"
        imgTick2.image = UIImage(named: "tick_icon")
        imgTick3.image = UIImage()
        imgTick1.image = UIImage()
    }
    @IBAction func btn_American(_ sender: Any) {
        strCardType = "AMERICANEXPRESS"
        imgTick3.image = UIImage(named: "tick_icon")
        imgTick2.image = UIImage()
        imgTick1.image = UIImage()
    }
    
}

extension CardPaymentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isFirstResponder {
            if (textField.textInputMode?.primaryLanguage == "emoji") || !((textField.textInputMode?.primaryLanguage) != nil) {
                return false
            }
        }
        
        if textField == tf_CardNumber {
            if MF.checkNumberInput(strInput: string) {
                let currentCharacterCount = tf_CardNumber?.text?.count ?? 0
                let newLength = currentCharacterCount + string.count - range.length
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                return newLength <= 20
            } else {
                return false
            }
        }
        if textField == tf_MM {
            if MF.checkNumberInput(strInput: string) {
                let currentCharacterCount = tf_MM?.text?.count ?? 0
                let newLength = currentCharacterCount + string.count - range.length
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                return newLength <= 2
            } else {
                return false
            }
        }
        
        if textField == tf_Year {
            if MF.checkNumberInput(strInput: string) {
                let currentCharacterCount = tf_Year?.text?.count ?? 0
                let newLength = currentCharacterCount + string.count - range.length
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                return newLength <= 4
            } else {
                return false
            }
        }
        
        if textField == tf_CVV {
            if MF.checkNumberInput(strInput: string) {
                let currentCharacterCount = tf_CVV?.text?.count ?? 0
                let newLength = currentCharacterCount + string.count - range.length
                if (range.length + range.location > currentCharacterCount){
                    return false
                }
                return newLength <= 3
            } else {
                return false
            }
        }
        return true
    }
}
