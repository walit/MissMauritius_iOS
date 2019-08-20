//
//  ValidationMessages.swift
//  Tyvo
//
//  Created by Gourav Joshi on 04/02/17.
//  Copyright © 2017 Gourav Joshi. All rights reserved.
//
import UIKit
import Foundation

struct ValidationMessages {
  
    static let validationFirstName = "Please enter first name"
    
    static let validationLastName = "Please enter last name"
    static let validationFullName = "Please enter your full name"
    static let validationMsgMobileNo = "Please enter mobile number"
    static let validationMsgMobileNoLength = "Mobile number at least contains 10 digits"
    static let validationMsgPassword = "Please enter password"
    static let validationMsgUserName = "Please enter user name"
    static let validationMsgEmail = "Please enter email"
    static let validationMsgValidEmail = "Please enter valid email"
    static let validationMsgPswd = "Please enter password"
    static let validationMsgPswdLength = "Password contains at least 6 character"
    static let validationComfirmPassword = "Please enter confirm password"
    static let validationPasswordNotMatch = "Passwords don't match"
    static let validationMsgPswdMatch = "Confirm password does not match with new password"
    static let validationMsgDob = "Please select Date of Birth"
    static let validationMsgBloodGrp = "Please select Blood Group"
    static let validationMsgCodeVerify = "Please enter verification code"
    static let validationMsgCity = "Please select city"
    static let validationMsgRegistration = "Please enter registration no."
    static let validationMsgCertificate = "Please upload certificate"
    static let validationMainCategory = "Please select main category"
    static let validationSubCategory = "Please select sub category"
    static let validationServices = "Please select services"
    static let validationMsgGender = "Please select gender"
    static let validationMsgSTD = "Please select std code"
    static let validationMsgState = "Please select state"
    static let validationMsgArea = "Please select area"
    static let validationMsgOtherArea = "Please enter other area"
    static let validationMsgStreet = "Please enter street"
    static let validationMsgAbout = "Please enter about you"
    static let validationMsgTermsCondition = "Please enter terms and conditions"
    static let validationMsgOldPswd = "Please enter old password"
    static let validationMsgNewPswd = "Please enter new password"
    static let strInternetIsNotAvailable = "Internet connection in not avaliable."
    static let serverCommError = "Server communication error, Please try again"
    static let validationMsgReportProblem = "Please enter your problem."
    static let validationMsgDate = "Please enter date."
    static let validationMsgTime = "Please enter time."
    static let validationMsgPatientName = "Please enter patient name."
    static let validationMsgDiseaseName = "Please enter disease name."
    static let validationMsgTermCondition = "Please select terms and conditions."
    static let validationMsgReview = "Please enter review."
    static let validationMsgSearch = "Please write something for search"

    static let logout = "Are you sure want to logout from app?"
    static let logoutSuccessfully = "You are logout successfully"
    
}

class ShowAlert {
    func showAlertViewWithDuration(_ message: String)  {
        let alert = UIAlertView(title: "", message: message, delegate: nil, cancelButtonTitle: nil)
        
        alert.alertViewStyle = .default
        alert.show()
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            alert.dismiss(withClickedButtonIndex: -1, animated: true)
        })
    }
    
    func showAlertViewWithMessage(_ strMessage: String) {
        let alert = UIAlertView(title: "", message: strMessage, delegate: nil, cancelButtonTitle: "Ok")
        alert.alertViewStyle = .default
        alert.show()
    }

}
