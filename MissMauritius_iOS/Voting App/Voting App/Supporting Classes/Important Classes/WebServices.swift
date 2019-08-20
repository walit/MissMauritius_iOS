//
//  WebServices.swift
//  Tyvo
//
//  Created by Gourav Joshi on 04/02/17.
//  Copyright © 2017 Gourav Joshi. All rights reserved.
//

import Foundation

struct Server {
    
    //  "http://smtgroup.in/miss_mauritius/api/index.php/UserLogin"
    
    private init() {}
    enum Scheme {
        static let Name = "http://"
        static let NewName = "https://"
    }
    enum HostName {
        static let Testing = String(format:"%@smtgroup.in/", Server.Scheme.Name)
        static let Live = String(format: "%@missmauritius.walit.net/", Server.Scheme.NewName)
    }
    enum Path {
        static let Test = "miss_mauritius/api/index.php/"
        static let Live = "api/V1/"
    }
    enum API {
        static let TestUrl = String(format: "%@%@", Server.HostName.Live, Server.Path.Live)
        static let Live = String(format: "%@%@", Server.HostName.Live, Server.Path.Live)
    }
    static let BaseURL = Server.API.Live
}

// MARK: Webservices Constants

struct WebServiceName {
  
    enum UserManagement {
        static let Login = "UserLogin"
        static let SignUp = "UserSignUp"
        static let ForgotPassword = "UserForgotPassword"
        static let Logout = "UserLogout"
        static let VerifyOTP = "UserSignUpVerifyOtp"
        static let VerifyOTPForgot = "VerifyOtp"
        static let UpdateProfile = "UpdateProfile"
        static let UpdatePhoto = "ChangeProfilePic"
        static let ResetPassword = "ResetPassword"
    }
    
    enum Contestant {
        static let List = "GetContestantlist"
        static let Voting = "Voting"
        static let LikeIt = ""
        static let Detail = "GetContestantDetail"
        static let Add = "AddContestant"
        static let Gallery = "GetContestantGalleryImage"
    }
    
    static let GetVotePrice = "VotePrice"
    static let OTPWallitPhone = "OptSentToWalitPhone"
    
    enum Payments {
        static let GetCheckout = ""
        static let BuyVote = "BuyVote"
        static let VerifyWalletOTP = "WalletPaymentOtpVerify"
        
    }
    
    enum Common {
        static let NotificationList = "GetNotificationList"
        static let AddComments = "AddComments"
        static let Committeelist = "GetCommitteeMemberList"
        static let PastWinners = "GetPastWinnerList"
    }
    
    enum Events {
        static let List = "GetEventList"
    }
}

