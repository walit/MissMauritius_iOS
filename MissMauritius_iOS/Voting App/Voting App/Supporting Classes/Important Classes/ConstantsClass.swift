//
//  ConstantsClass.swift
//  Tyvo
//
//  Created by Gourav Joshi on 04/02/17.
//  Copyright © 2017 Gourav Joshi. All rights reserved.
//
import UIKit
import Foundation
import CoreLocation

// MARK: Basic Constants Details:

let DEVICEID = UIDevice.current.identifierForVendor
let MainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
let CustomPopUpStoryBoard = UIStoryboard(name: "CustomPopUp", bundle: nil)

let OB_WEBSERVICE = WebServiceClass()



let SHOWALERT = ShowAlert()
let MF = SupportingFunctions()
let obDate = DateClassFunctions()
var obUser:UserProfileModel? = UserProfileModel.sharedInstance()


let dateFormatCustom = DateFormatter()
let DateFormat_DMMY = "dd MMMM YYYY"
let DateFormat_YMD = "YYYY-MM-dd"
let DateFormat_YMD_HM = "YYYY-MM-dd hh:mm a"
let DateFormat_YMD_HMS = "YYYY-MM-dd hh:mm:ss"
let DateFormat_DMYE = "dd MMM YYYY, EEEE"
let DateFormat_YMD_HMS1 = "YYYYMMddhhmmss"
let DateFormat_MD = "MM-dd"
let DateFormat_12HM = "hh:mm a"
let DateFormat_24HM = "HH:mm"
let DateFormat_DMY = "dd, MMM YYYY"
let DateFormat_YMD_HMS2 = "YYYY-MM-dd HH:mm:ss"

let AnswerSeperator = "|*|"
   
var SESSION = URLSession.shared   /// Its a singleton of session that creates a default session

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
let ApplicationVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let AppVersion = Double(ApplicationVersion)

let PageLimit = 10
let fSize = CGFloat(13.0)

let dullWhite = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
let Preferences:UserDefaults? = UserDefaults.standard

 let PageCounter = PageLimit
 let kAutoScrollDuration: CGFloat = 6.0 /// This will scroll the images automatically
 let blockSize = 100

let ThemeMessage = "It's time for a star to shine Beauty with purpose 2019"


struct TextObjects {
    static let textColor = UIColor.white
    static let placeHolderColor = UIColor.white
    static let selectedColor = UIColor.orange
    static let borderWidth = CGFloat(1.0)
    static let cornerRadius = CGFloat(8.0)
    static let paddingPoints = CGFloat(10.0)
    static let themeColorGreen = UIColor(red: 41/255, green: 175/255, blue: 25/255, alpha: 1)
    static let themeColorGray = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1)
}

struct CustomColors {
    static let bottomColor = UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1)
    static let appThemeColor = UIColor(red: 251/255, green: 87/255, blue: 95/255, alpha: 1)
    static let Red = UIColor.red
    static let Green = UIColor(red: 41/255, green: 175/255, blue: 25/255, alpha: 1)
    static let Blue = UIColor(red: 21/255, green: 146/255, blue: 211/255, alpha: 1)
    static let Indigo = UIColor(red: 75/255, green: 0/255, blue: 130/255, alpha: 1)
    static let Magenta = UIColor.magenta
    static let FreshGreen = UIColor(red: 77/255, green: 196/255, blue: 122/255, alpha: 1)
    static let Orange = UIColor(red: 255/255, green: 69/255, blue: 0/255, alpha: 1)
    static let Brown = UIColor(red: 139/255, green: 69/255, blue: 19/255, alpha: 1)
    static let Voilet = UIColor(red: 138/255, green: 43/255, blue: 226/255, alpha: 1)
    static let themeColorYellow = UIColor(red: 221/255, green: 194/255, blue: 103/255, alpha: 1)
    static let themeColorGreen = UIColor(red: 44/255, green: 189/255, blue: 165/255, alpha: 1)
    static let DarkBlue = UIColor(red: 121/255, green: 134/255, blue: 142/255, alpha: 1)
    static let StarYellow = UIColor(red: 252/255, green: 223/255, blue: 101/255, alpha: 1)
    static let RandomColor = UIColor(red: CGFloat(arc4random() % 255/255), green:  CGFloat(arc4random() % 255/255), blue: CGFloat(arc4random() % 255/255), alpha: 1)
}

struct ValidationConstants {
    static let MobileNumberLength = 9
    static let MaxMobileNumberLength = 10
    static let MaxOTPLength = 6
    static let PasswordLength = 6
    static let MaxPasswordLength = 12
    static let DeviceType = "ios"
    static let MaxDescriptionLimit = 300
}

struct AppLinks {
    static let GoogleAppStoreLink = "https://play.google.com/store/apps/details?id=app.bundle.id"
    static let AppleAppStoreLink = "https://itunes.apple.com/us/app/your_app_name/id_app_id?ls=1&mt=8"
}

struct PreferencesKeys {
    static let savedItems = "savedItems"
    static let questionScreen = "questionScreen"
}

struct WebContentName {
    static let TermsAndConditions = NSLocalizedString("TermsConditions", comment: "")
    static let PrivacyPolicy = "Privacy Policy"
    static let AboutUs =   NSLocalizedString("AboutUs", comment: "")
    static let ContactUs =   NSLocalizedString("ContactUs", comment: "")
    static let Standards =   NSLocalizedString("StandardPractice", comment: "")
}

struct ScreenSize {
    static let SCREEN_WIDTH         =   UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        =   UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    
    static let IS_PHONE = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO    = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

struct Version {
    static let SYS_VERSION = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS7 = (Version.SYS_VERSION < 8.0 && Version.SYS_VERSION >= 7.0)
    static let iOS8 = (Version.SYS_VERSION >= 8.0 && Version.SYS_VERSION < 9.0)
    static let iOS9 = (Version.SYS_VERSION >= 9.0 && Version.SYS_VERSION < 10.0)
    static let iOS10 = (Version.SYS_VERSION >= 10.0 && Version.SYS_VERSION < 11.0)
    static let iOS11 = (Version.SYS_VERSION >= 11.0 && Version.SYS_VERSION < 12.0)
    static let iOS12 = (Version.SYS_VERSION >= 12.0 && Version.SYS_VERSION < 13.0)
}

struct NotificationType {
   
}

/*
 Help to manage question priority
*/
enum QuestionPriority {
    static let Low = 1
    static let Medium = 2
    static let High = 3
}

enum PopUpType {
    static let Simple = 1
    static let Action = 2
    static let Check = 3
    static let Toast = 4
    static let SimpleAction = 5
}

enum MethodType {
    static let Get =    "GET"
    static let Post =   "POST"
    static let Put =     "PUT"
    static let Patch = "PATCH"
}

struct SettingContent {
    enum Sections {
        static let PushNotification = NSLocalizedString("PushNotification1", comment: "")
        static let Pages = NSLocalizedString("Pages", comment: "")
        static let ContactUs = NSLocalizedString("ContactUs1", comment: "")
    }
    
    static let AssignAudit  = NSLocalizedString("AssignAudit", comment: "")
    static let NewAudit  = NSLocalizedString("NewAudit", comment: "")
    static let SyncAudit  = NSLocalizedString("SyncAudit", comment: "")
    static let Notification  = NSLocalizedString("PushNotification1", comment: "")
    static let ContactUs = NSLocalizedString("ContactUs1", comment: "")
    static let ChangePassword = NSLocalizedString("ChangePassword1", comment: "")
    static let AboutUs = NSLocalizedString("AboutUs1", comment: "")
    static let News = NSLocalizedString("News1", comment: "")
    static let Standars = NSLocalizedString("StandardPractice1", comment: "")
    static let TermsConditions = NSLocalizedString("TermsConditions1", comment: "")
    static let Help = NSLocalizedString("Help", comment: "")
    static let Logout = NSLocalizedString("Logout", comment: "")
}

enum ProfileContent {
    static let UpdateDetail = NSLocalizedString("UpdateDetails", comment: "")
    static let ChatAdmin = NSLocalizedString("ChatAdmin", comment: "")
    static let ShareApp = NSLocalizedString("ShareApp", comment: "")
    static let HowUse = NSLocalizedString("HowUse", comment: "")
}

enum MenuItems {
    
    static let Profile = "Profile"
    static let Event = "Event"
    static let PastWinner = "Past Winners"
    static let Gallery = "Gallery"
    static let Committee = "Committee"
    static let Sponsor = "Sponsor"
    static let Notification = "Notification"
    static let AboutUs = "About us"
    static let ContactUs = "Contact us"
}

enum MenuIcons {
    
    static let Profile = "profile_icon"
    static let Event = "event_icon"
    static let PastWinner = "winner_icon"
    static let Committee = "winner_icon"
    static let Gallery = "gallery_icon"
    static let Sponsor = "gallery_icon"
    static let Notification = "notification_icon"
    static let AboutUs = "aboutus_icon"
    static let ContactUs = "aboutus_icon"
}

enum AccountItems {
    static let ProfileDetails = "PROFILE DETAILS"
    static let ChangePassword = "CHANGE PASSWORD"
    static let YourEvents = "YOUR EVENTS"
    static let YourSponsor = "YOUR SPONSORS"
    static let RedeemedOffer = "REDEEMED OFFER"
    static let AvailedOffer = "AVAILED OFFER"
    static let FavoriteProfile = "FAVORITE PROFILE"
    static let FavoriteBlog = "FAVORITE BLOG"
}

enum AccountIcons {
    static let ProfileDetails = "Profile"
    static let ChangePassword = "ChangePassword"
    static let YourEvents = "YourEvent"
    static let YourSponsor = "ic_sponsororange"
    static let RedeemedOffer = "RedeemedOffer"
    static let AvailedOffer = "AvailedOffer"
    static let FavoriteProfile = "FavoriteProfile"
    static let FavoriteBlog = "FavoriteBlog"
}

enum AppointmentItems {
    static let All = "ALL APPOINTMENTS"
    static let Scheduled = "SCHEDULED"
    static let Cancelled = "CANCELLED"
    static let Completed = "COMPLETED"
}

enum AppointmentIcons {
    static let All = "Calender_allAppointment"
    static let Scheduled = "Calender_Sechduled"
    static let Cancelled = "Calender_Cancelled"
    static let Completed = "Calender_completed"
}

enum MediaFilesMetaDataConstants {
    static let FileData = "file_data"
    static let FileName = "file_name"
    static let FileUrl = "file_url"
    static let FileType = "file_type"
    static let Thumbnail = "thumbnail"
    static let TagId = "tag_id"
    static let FileType_URL = "1"
    static let FileType_Image = "0"
}


