//
//  EditProfileViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 25/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    var imagePicker:UIImagePickerController? = UIImagePickerController()
    @IBOutlet weak var imgView_User: UIImageView!
    var flagIsUploadPic = Bool()
    @IBAction func btn_UploadPhoto(_ sender: Any) {
        MF.openActionSheet(with: imagePicker!, and: self, targetFrame: (btn_UploadPhoto.frame))
    }
    
    
    @IBOutlet weak var btn_UploadPhoto: UIButton!
    @IBOutlet weak var btn_Update: UIButton!
    @IBOutlet weak var tf_FirstName: UITextField!
    @IBOutlet weak var tf_LastName: UITextField!
    @IBOutlet weak var tf_Email: UITextField!
    @IBOutlet weak var tf_MobileNo: UITextField!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var view_Content: UIView!
    
    @IBOutlet weak var tfHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewWidthConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        if DeviceType.IS_IPHONE_5 {
            tfHeightConstraint.constant = 38.0
            imgViewHeightConstraint.constant = 100
            imgViewWidthConstraint.constant = 100
            imgView_User.layer.borderColor = UIColor.white.cgColor
            imgView_User.layer.cornerRadius = 50.0
         //   imgView_User.clipsToBounds = true
        }
         tf_FirstName.setLeftPaddingPoints(5.0)
         tf_LastName.setLeftPaddingPoints(5.0)
         tf_Email.setLeftPaddingPoints(5.0)
         tf_MobileNo.setLeftPaddingPoints(5.0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !flagIsUploadPic {
            getAndSetUserData()
        }
    }
    
    func getAndSetUserData() {
        tf_FirstName.text = obUser?.firstName
        tf_LastName.text = obUser?.lastName
        tf_MobileNo.text = obUser?.phone
        tf_Email.text = obUser?.email
        imgView_User.sd_setImage(with: URL(string: obUser!.imgUrl!), placeholderImage: UIImage.init(named: "img_user"))
    }

    override func viewDidLayoutSubviews() {
        view_Content.frame = CGRect(x: 0, y: 0, width: scrlView.frame.size.width, height: btn_Update.frame.origin.y + btn_Update.frame.size.height + 40)
        scrlView.frame = CGRect(x: scrlView.frame.origin.x, y: scrlView.frame.origin.y , width: scrlView.frame.size.width, height: view_Content.frame.size.height)
        scrlView.contentSize = CGSize(width: scrlView.frame.size.width, height: view_Content.frame.size.height)
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Update(_ sender: Any) {
        if checkValidations().count > 0 {
            self.showAlertViewWithMessage(checkValidations(), vc: self)
        } else {
            submitUpdateProfileRequest()
        }
    }
    
    func checkValidations() -> String {
        var strMsg = String()
        
        if tf_FirstName.text?.count == 0 {
            strMsg = ValidationMessages.validationFullName
        } else if tf_LastName.text?.count == 0 {
            strMsg = ValidationMessages.validationLastName
        }
        return strMsg
    }
    
    func submitUpdateProfileRequest() {
        let dictP = NSMutableDictionary()
        dictP.setValue(tf_FirstName?.text, forKey: "first_name")
        dictP.setValue(tf_LastName?.text, forKey: "last_name")
      //  dictP.setValue(obUser?.userId, forKey: "user_id")
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.UserManagement.UpdateProfile, methodType: 1, forContent: 3, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                obUser?.firstName = self.tf_FirstName.text
                obUser?.lastName = self.tf_LastName.text
                self.showAlertViewWithDuration("Profile update successfully", vc: self)
                MF.setUserDataForPreference()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
                
                
            }
        }
    }
    
     func submitUploadPhotoRequest() {
        
        var imageData = imgView_User.image?.imageQuality(.low)
        if imageData == nil  {
            imageData = NSData() as Data
        }
        
        let dictP = MF.initializeDictWithUserId()
        dictP.setValue("profile_pic", forKey: "fileKey")
        dictP.setValue(imageData, forKey: "fileData")
        
        OB_WEBSERVICE.uploadImageData(webService: WebServiceName.UserManagement.UpdatePhoto, methodType: 1, forContent: 1, OnView: self, withParameters: dictP) { (dictJson, status) in
            if status == 1 {
                obUser?.imgUrl = (dictJson["data"] as! NSDictionary)["profile_pic"] as? String
                MF.setUserDataForPreference()
            }
        }
    }
    
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.flagIsUploadPic = true
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        self.imgView_User.image = image
        self.executeUIProcess {
            self.submitUploadPhotoRequest()
        }
        picker.dismiss(animated: false, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.flagIsUploadPic = false
        dismiss(animated: true, completion: nil)
    }
}
