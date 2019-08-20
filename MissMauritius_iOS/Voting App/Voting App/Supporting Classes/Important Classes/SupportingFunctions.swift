//
//  Supporting Functions.swift
//  Productivity Planner
//
//  Created by Gourav Joshi on 29/05/18.
//  Copyright © 2018 Gourav Joshi. All rights reserved.
//

import UIKit
import SystemConfiguration

class SupportingFunctions: NSObject {
    
    //MARK: Decode Data String
    func decodeDataIntoString(strMsg: String) -> String {
        
        let strDecodeMsg = strMsg
        var strString = ""
        if( strDecodeMsg.count > 0) {
            let jsonString = strDecodeMsg.cString(using: String.Encoding.utf8)
            let jsonData = NSData(bytes: jsonString!, length: jsonString!.count)
            let msgData: Data = jsonData as Data
            if(msgData.count > 0){
                if(String(data: msgData , encoding: String.Encoding.nonLossyASCII) != nil) {
                    strString = String(data: msgData , encoding: String.Encoding.nonLossyASCII)!
                } else {
                    strString = strDecodeMsg
                }
            } else {
                strString = strDecodeMsg
            }
        }
        return strString
    }
    
    func decodeUnicodeStringIntoSimpleString(strMsg: String) -> String {
        
        if strMsg.count > 0 {
            var simpleString = ""
            let datadec  = strMsg.data(using: String.Encoding.utf8)
            if datadec == nil {
                simpleString = decodeDataIntoString(strMsg: strMsg)
            } else {
                simpleString = String(data: datadec!, encoding: String.Encoding.nonLossyASCII)!
            }
            return simpleString
        }
        return ""
    }
    
    func fileSize(forURL url: Any) -> Double {
        var fileURL: URL?
        var fileSize: Double = 0.0
        if (url is URL) || (url is String) {
            if (url is URL) {
                fileURL = url as? URL
            } else {
                fileURL = URL(fileURLWithPath: url as! String)
            }
            var fileSizeValue = 0.0
            try? fileSizeValue = (fileURL?.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).allValues.first?.value as! Double?)!
            if fileSizeValue > 0.0 {
                fileSize = (Double(fileSizeValue) / (1024 * 1024))
            }
        }
        return fileSize
    }
    
    //MARK: Check Validation Inputs
    func checkNumberInput(strInput: String) ->Bool {
        let allowedCharacters = "1234567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: strInput)
        let isNumber = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        return isNumber
    }
    
    func checkAlphabetInput(strInput: String) -> Bool {
        let allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: strInput)
        let isAlphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        return isAlphabet
    }
    
    func numberFormatter(number: String) -> String {
        let formatter = NumberFormatter()
        formatter.locale = NSLocale.current   // you can specify locale that you want
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        
        let returnNumber = formatter.number(from: number)
      //  print("returnNumber = \(returnNumber?.stringValue)")
        return (returnNumber?.stringValue)!
    }
    
    //MARK: Image Picker
    func openActionSheet(with imagePicker: UIImagePickerController, and delegate: UIViewController, targetFrame: CGRect ,isShowArrow: Bool = true)  {
        
        let optionMenu = UIAlertController(title: nil, message: NSLocalizedString("ChoosePhoto", comment: ""), preferredStyle: .actionSheet)
        let openCapturePhotoAction = UIAlertAction(title: NSLocalizedString("TakePhoto", comment: ""), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            autoreleasepool {
                imagePicker.delegate = delegate as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                delegate.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        let openGalleryPhotoAction = UIAlertAction(title: NSLocalizedString("PhotoLibrary", comment: ""), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            imagePicker.delegate = delegate as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
          
            imagePicker.modalPresentationStyle = .popover
            delegate.present(imagePicker, animated: true)
            
            // Get the popover presentation controller and configure it.
            let presentationController: UIPopoverPresentationController? = imagePicker.popoverPresentationController
            presentationController?.permittedArrowDirections = .up
            presentationController?.sourceView = delegate.view
            presentationController?.sourceRect = targetFrame
        })
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            optionMenu.addAction(openCapturePhotoAction)
        }
        optionMenu.addAction(openGalleryPhotoAction)
        optionMenu.addAction(cancelAction)
        optionMenu.popoverPresentationController?.sourceRect = targetFrame
        optionMenu.popoverPresentationController?.sourceView = delegate.view
        if isShowArrow == false {
            optionMenu.popoverPresentationController?.permittedArrowDirections = []
        }
        autoreleasepool {
            delegate.present(optionMenu, animated: true, completion: nil) 
        }
    }
    
    func openActionSheetDemo(with imagePicker: UIImagePickerController, and delegate: UIViewController, targetFrame: CGRect, sender: AnyObject ,isShowArrow: Bool = true)  {
        let optionMenu = UIAlertController(title: nil, message: NSLocalizedString("ChoosePhoto", comment: ""), preferredStyle: .actionSheet)
        let openCapturePhotoAction = UIAlertAction(title: NSLocalizedString("TakePhoto", comment: ""), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            imagePicker.delegate = delegate as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            delegate.present(imagePicker, animated: true, completion: nil)
        })
        
        let openGalleryPhotoAction = UIAlertAction(title: NSLocalizedString("PhotoLibrary", comment: ""), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            imagePicker.delegate = delegate as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.modalPresentationStyle = .popover
            
            imagePicker.modalPresentationStyle = .popover
            delegate.present(imagePicker, animated: true)
            
            // Get the popover presentation controller and configure it.
            let presentationController: UIPopoverPresentationController? = imagePicker.popoverPresentationController
            presentationController?.permittedArrowDirections = .up
            presentationController?.sourceView = delegate.view
            presentationController?.sourceRect = targetFrame
            
            
        })
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            optionMenu.addAction(openCapturePhotoAction)
        }
        optionMenu.addAction(openGalleryPhotoAction)
        optionMenu.addAction(cancelAction)
        optionMenu.popoverPresentationController?.sourceRect = targetFrame
        optionMenu.popoverPresentationController?.sourceView = delegate.view
        if isShowArrow == false {
            optionMenu.popoverPresentationController?.permittedArrowDirections = []
        }
        delegate.present(optionMenu, animated: true, completion: nil)
    }
    
    func resize(image: UIImage, maxHeight: Float = 500.0, maxWidth: Float = 500.0) -> UIImage? {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }  else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in:rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        ///    let imageData = UIImageJPEGRepresentation(img!,CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return img
    }
    
    func ShowPopUpViewOn(viewController: UIViewController, popUpType: Int, title:String = "Alert!", message:String) {
        
        let modalViewController = CustomPopUpStoryBoard.instantiateViewController(withIdentifier: "CustomPopUpViewController") as! CustomPopUpViewController
        modalViewController.view.isOpaque = false
        modalViewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        modalViewController.modalPresentationStyle = .overCurrentContext
        
        if popUpType == PopUpType.Simple {
            modalViewController.ShowPopUpWithOk(title: title, message: message)
        } else if popUpType == PopUpType.Action {
            modalViewController.ShowPopUpWithAction(title: title, message: message, delegate: viewController)
        } else if popUpType == PopUpType.Toast {
            modalViewController.ShowPopUpToast(title: title, message: message, delegate: viewController)
        } else if popUpType == PopUpType.SimpleAction {
            modalViewController.ShowPopUpWithOkAction(title: title, message: message, delegate: viewController)
        }
        
        viewController.view.superview?.insertSubview(modalViewController.view, aboveSubview: viewController.view)
        viewController.present(modalViewController, animated: false, completion: nil)
        if popUpType == PopUpType.Toast {
            let delay = 2.5 * Double(NSEC_PER_SEC)
            let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                modalViewController.dismiss(animated: false, completion: nil)
            })
        }
    }
    
    //MARK: Menu View
    func OpenMenuView(viewController: UIViewController) {
        
        let modalViewController = MainStoryBoard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        modalViewController.view.isOpaque = false

        modalViewController.view.backgroundColor = UIColor.clear
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.view.transform = CGAffineTransform(translationX: -viewController.view.frame.size.width, y: 0)
        viewController.view.superview?.insertSubview(modalViewController.view, aboveSubview: viewController.view)
        //viewController.view.frame.size.width
        UIView.animate(withDuration: 0.40,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        modalViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: { finished in
            viewController.present(modalViewController, animated: false, completion: nil)
        })
    }
    
    //MARK: Image Picker
    func openActionSheetForChat(with imagePicker: UIImagePickerController, with documentPicker: UIDocumentPickerViewController, and delegate: UIViewController , targetFrame: CGRect)  {
        let optionMenu = UIAlertController(title: nil, message: NSLocalizedString("ChooseMedia", comment: ""), preferredStyle: .actionSheet)
        let openCapturePhotoAction = UIAlertAction(title: NSLocalizedString("TakePhoto", comment: ""), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            imagePicker.delegate = delegate as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            delegate.present(imagePicker, animated: true, completion: nil)
        })
        
        let openGalleryPhotoAction = UIAlertAction(title: NSLocalizedString("PhotoLibrary", comment: ""), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            imagePicker.delegate = delegate as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image","public.movie"]
            delegate.present(imagePicker, animated: true, completion: nil)
        })
        
        let openDocummentAction = UIAlertAction(title: NSLocalizedString("Document", comment: ""), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            documentPicker.delegate = delegate as? UIDocumentPickerDelegate & UINavigationControllerDelegate
            delegate.present(documentPicker, animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            optionMenu.addAction(openCapturePhotoAction)
        }
        optionMenu.addAction(openGalleryPhotoAction)
        optionMenu.addAction(openDocummentAction)
        optionMenu.addAction(cancelAction)
        
        optionMenu.popoverPresentationController?.sourceRect = targetFrame
        optionMenu.popoverPresentationController?.sourceView = delegate.view
        optionMenu.popoverPresentationController?.permittedArrowDirections = []
        delegate.present(optionMenu, animated: true, completion: nil)
    }
    
    func animateViewNavigation(navigationController: UINavigationController) {
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.duration = 0.35
        transition.timingFunction = timeFunc
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        navigationController.view.layer.add(transition, forKey: kCATransition)
    }
        
    //MARK: Set TextView Underline
    func setTextViewUnderline(textField: UITextView)  {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = TextObjects.themeColorGray.cgColor
        textField.layer.addSublayer(bottomLine)
    }
    
    //MARK: Set TextField Underline
    func setTextFieldUnderline(textField: UITextField)  {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = TextObjects.themeColorGray.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
    
    //MARK: Set Button Underline
    func setButtonUnderline(textField: UIButton)  {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = TextObjects.themeColorGray.cgColor
        textField.layer.addSublayer(bottomLine)
    }
    
    //MARK: Button Border and Backgrounds :
    func setGreenBorder(button: UIButton) {
        button.layer.borderColor = TextObjects.themeColorGreen.cgColor
        button.layer.borderWidth = 1.0
        button.setTitleColor(TextObjects.themeColorGreen, for: UIControl.State.normal)
        button.clipsToBounds = true
    }
    
    func setGrayBorder(button: UIButton) {
        button.layer.borderColor = TextObjects.themeColorGray.cgColor
        button.layer.borderWidth = 1.0
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.clipsToBounds = true
    }
    
    func setWhiteBackground(button: UIButton) {
        button.backgroundColor = CustomColors.Blue
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
    func setClearBackground(button: UIButton) {
        button.backgroundColor = UIColor.clear
        button.setTitleColor(CustomColors.Blue, for: UIControl.State.normal)
    }
    
    func setButtonBorderAndText(button: UIButton, borderColor: UIColor, textColor: UIColor, backgroundColor: UIColor) {
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = 1.0
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.backgroundColor = backgroundColor
        button.clipsToBounds = true
    }
    
    func initializeDictWithUserId() -> NSMutableDictionary {
        var strUserId = String()
        var strUserEncodedId = String()
        if let userId = Preferences?.value(forKey: "userId") as! String? {
            strUserEncodedId = userId.toBase64()
            strUserId = userId
        }
        
        let dictP = NSMutableDictionary()
        dictP.setValue(strUserId, forKey: "user_id")
       
        return dictP
    }
    
    func setUserDataForPreference()  {
        let dictP = NSMutableDictionary()
        dictP.setValue(obUser?.firstName, forKey: "first_name")
        dictP.setValue(obUser?.lastName, forKey: "last_name")
        dictP.setValue(obUser?.phone, forKey: "phone")
        dictP.setValue(obUser?.email, forKey: "email")
        dictP.setValue(obUser?.imgUrl, forKey: "image")
        
        do {
            let archiveUserData = try? NSKeyedArchiver.archivedData(withRootObject: dictP.mutableCopy(), requiringSecureCoding: true)
            Preferences?.set(archiveUserData , forKey: "UserData")
        } catch let e as Error {
            print("exception = \(e.localizedDescription)")
        }
        
        do {
            let unarchiveUserData: NSMutableDictionary = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData((Preferences?.object(forKey: "UserData") as! NSData) as Data) as! NSMutableDictionary
            obUser?.initWith(dict: unarchiveUserData.mutableCopy() as! NSMutableDictionary)
        } catch let e as Error {
            print("exception = \(e.localizedDescription)")
        }
        
    }
    
    func logoutAndClearAllSessionData() {
        let email = Preferences?.value(forKey: "mobile")
        let password = Preferences?.value(forKey: "password")
        let isRemember = Preferences?.value(forKey: "isRemember")
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        Preferences?.setValue(email, forKey: "mobile")
        Preferences?.setValue(password, forKey: "password")
        Preferences?.set(isRemember, forKey: "isRemember")
        /*
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
        */
        let vc1 = MainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
        navigationController.viewControllers = [vc1]
        kAppDelegate.window?.rootViewController = navigationController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
         //   kAppDelegate.window?.rootViewController?.showAlertViewWithDuration("Your session timeout", vc: kAppDelegate.window!.rootViewController!)
        }
        
    }
    
    func addShadowToView(viewShadow: UIView, andRadius radius: Int) {
        viewShadow.layer.shadowColor = UIColor.black.cgColor
        viewShadow.layer.shadowOpacity = 1
        viewShadow.layer.shadowOffset = CGSize.zero
        viewShadow.layer.shadowRadius = CGFloat(radius)
    }
    
    func addBorderAndCornerRadius(view: UIView, andRadius radius: Int) {
        view.layer.cornerRadius = CGFloat(radius)
        view.clipsToBounds = false
        view.layer.masksToBounds = false
    }
    
    func setBoldTextInLabel(boldText: String, normalText: String, fontSize: CGFloat) -> NSAttributedString {
        let spaceString = boldText  + " " 
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fontSize)]
        let attributedString = NSMutableAttributedString(string:spaceString, attributes:attrs)
        
        let normalText = normalText
        let normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        return attributedString
    }
    
    func setUpNotificationArray() -> NSMutableArray {
        let arr = NSMutableArray()
        arr.add(SettingContent.AssignAudit)
        arr.add(SettingContent.NewAudit)
        arr.add(SettingContent.SyncAudit)
        return arr
    }
    
    func setUpPageArray() -> NSMutableArray {
        let arr = NSMutableArray()
        arr.add(SettingContent.AboutUs)
        arr.add(SettingContent.TermsConditions)
        arr.add(SettingContent.Standars)
        arr.add(SettingContent.News)
        return arr
    }
    
    func setUpContactUsArray() -> NSMutableArray {
        let arr = NSMutableArray()
        arr.add(SettingContent.ContactUs)
        arr.add(SettingContent.ChangePassword)
        arr.add(SettingContent.Help)
        arr.add(SettingContent.Logout)
        return arr
    }
    
    func setUpMenuContent() -> [MenuModel] {
        
        var arr:[MenuModel]? = [MenuModel]()
        
      
        
        let obM2 = MenuModel()
        obM2.initWith(name: MenuItems.Profile, icon: MenuIcons.Profile)
        arr?.append(obM2)
        
        let obM3 = MenuModel()
        obM3.initWith(name: MenuItems.Event, icon: MenuIcons.Event)
        arr?.append(obM3)
        
        let obM4 = MenuModel()
        obM4.initWith(name: MenuItems.PastWinner, icon: MenuIcons.PastWinner)
        arr?.append(obM4)
        
        let obM5 = MenuModel()
        obM5.initWith(name: MenuItems.Gallery, icon: MenuIcons.Gallery)
        arr?.append(obM5)
        
        let obM1 = MenuModel()
        obM1.initWith(name: MenuItems.Sponsor, icon: MenuIcons.Sponsor)
        arr?.append(obM1)
        
        let obM9 = MenuModel()
        obM9.initWith(name: MenuItems.Committee, icon: MenuIcons.PastWinner)
        arr?.append(obM9)
        
        
        let obM6 = MenuModel()
        obM6.initWith(name: MenuItems.Notification, icon: MenuIcons.Notification)
        arr?.append(obM6)
        
        
        let obM7 = MenuModel()
        obM7.initWith(name: MenuItems.AboutUs, icon: MenuIcons.AboutUs)
        arr?.append(obM7)
        
        
        let obM8 = MenuModel()
        obM8.initWith(name: MenuItems.ContactUs, icon: MenuIcons.ContactUs)
        arr?.append(obM8)
        
        return arr!
    }
    
    func resizeImageWithDeviceSize(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = ScreenSize.SCREEN_WIDTH  / image.size.width
        let heightRatio = (ScreenSize.SCREEN_WIDTH / 2.5) / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x:0,y: 0,width: newSize.width, height:  newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
   
    
    func cropBottomImage(image: UIImage) -> UIImage {
        let height = CGFloat(image.size.height / 3)
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height - (height + 50))
        return cropImage(image: image, toRect: rect)
    }
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    //MARK: Check INternet Connection
    
    func isInternetAvailable() -> Bool   {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
