//
//  EditProfileViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 25/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class AddContestantViewController: UIViewController {
    
    @IBOutlet weak var datePkr: UIDatePicker!
    @IBAction func btn_PkrCancel(_ sender: Any) {
        tf_Dob.resignFirstResponder()
    }
    @IBAction func btn_PkrDone(_ sender: Any) {
     
        if Date().checkYears(from: datePkr.date) >= 18 {
            tf_Dob.text = obDate.changeDateToStringWith(dateFormat: "YYYY/MM/dd", date: datePkr.date)
            tf_Dob.resignFirstResponder()
        } else {
            showAlertViewWithMessage("Your age must greater than 18 years", vc: self)
        }
    }
    

    @IBOutlet var view_DatePkr: UIView!
    @IBOutlet weak var tf_Surname: DesignableUITextField!
    
    @IBOutlet weak var tf_OtherName: DesignableUITextField!
    
    @IBOutlet weak var tv_Address: UITextView!
    @IBOutlet weak var tf_Email: DesignableUITextField!
    @IBOutlet weak var tf_Mobile: DesignableUITextField!
    @IBOutlet weak var tf_telephone: DesignableUITextField!
    @IBOutlet weak var tf_Weight: DesignableUITextField!
    @IBOutlet weak var tf_Height: DesignableUITextField!
    @IBOutlet weak var tf_Dob: DesignableUITextField!
    @IBOutlet weak var tf_Age: DesignableUITextField!
    
    var imagePicker:UIImagePickerController? = UIImagePickerController()
    @IBOutlet weak var imgView_User: UIImageView!
    var flagIsUploadPic = Bool()
    @IBAction func btn_UploadPhoto(_ sender: Any) {
        MF.openActionSheet(with: imagePicker!, and: self, targetFrame: (btn_UploadPhoto.frame))
    }
    
    @IBOutlet weak var tf_Address: UITextView!
    @IBOutlet weak var btn_UploadPhoto: UIButton!
    @IBOutlet weak var btn_Update: UIButton!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var view_Content: UIView!
    
    @IBOutlet weak var tfHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewWidthConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_Address.delegate = self
        tf_Dob.inputView = view_DatePkr
        
        if DeviceType.IS_IPHONE_5 {
            tfHeightConstraint.constant = 38.0
            imgViewHeightConstraint.constant = 100
            imgViewWidthConstraint.constant = 100
            imgView_User.layer.borderColor = UIColor.white.cgColor
            imgView_User.layer.cornerRadius = 50.0
         //   imgView_User.clipsToBounds = true
        }
         tf_Surname.setLeftPaddingPoints(5.0)
         tf_Age.setLeftPaddingPoints(5.0)
         tf_OtherName.setLeftPaddingPoints(5.0)
         tf_Email.setLeftPaddingPoints(5.0)
         tf_Mobile.setLeftPaddingPoints(5.0)
         tf_telephone.setLeftPaddingPoints(5.0)
         tf_Height.setLeftPaddingPoints(5.0)
        tf_Weight.setLeftPaddingPoints(5.0)
        tf_Dob.setLeftPaddingPoints(5.0)
        // Do any additional setup after loading the view.
    //    tv_Address.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !flagIsUploadPic {
    
        }
    }
    
    override func viewDidLayoutSubviews() {
        view_Content.frame = CGRect(x: 0, y: 0, width: scrlView.frame.size.width, height: btn_Update.frame.origin.y + btn_Update.frame.size.height + 40)
        scrlView.contentSize = CGSize(width: scrlView.frame.size.width, height: view_Content.frame.size.height)
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Update(_ sender: Any) {
        if checkValidations().count > 0 {
            self.showAlertViewWithMessage(checkValidations(), vc: self)
        } else {
            submitAddContestantRequest()
        }
    }
    
    func checkValidations() -> String {
        var strMsg = String()
        
        if tf_Surname.text?.count == 0 {
            strMsg = "Please enter surname"
        } else if tf_OtherName.text?.count == 0 {
             strMsg = "Please enter other name"
        } else if tf_Age.text?.count == 0 {
            strMsg = "Please enter age"
        } else if tf_Dob.text?.count == 0 {
            strMsg = "Please select date of birth"
        } else if tf_Height.text?.count == 0 {
            strMsg = "Please enter height"
        } else if tf_Weight.text?.count == 0 {
            strMsg = "Please enter weight"
        } else if tf_telephone.text?.count == 0 {
            strMsg = "Please enter telephone"
        } else if tf_Mobile.text?.count == 0 {
            strMsg = "Please enter mobile"
        } else if tf_Email.text?.count == 0 {
            strMsg = "Please enter email"
        } else if tv_Address.text.count == 0 {
            strMsg = "Please enter address"
        }
        return strMsg
    }
    
    func submitAddContestantRequest() {
        
        var imageData = imgView_User.image?.imageQuality(.low)
        if imageData == nil  {
            imageData = NSData() as Data
        }
        
        let dictImg = MF.initializeDictWithUserId()
        dictImg.setValue("image", forKey: "fileKey")
        dictImg.setValue(imageData, forKey: "fileData")
        
        let dictP = NSMutableDictionary()
        dictP.setValue(tf_Surname?.text, forKey: "surname")
        dictP.setValue(tf_Age?.text, forKey: "age")
        dictP.setValue(tf_OtherName?.text, forKey: "other_name")
        dictP.setValue(tf_Weight?.text, forKey: "weight")
        dictP.setValue(tf_Height?.text, forKey: "height")
        dictP.setValue(tf_Dob?.text, forKey: "date_of_birth")
        dictP.setValue(tf_Mobile?.text, forKey: "phone")
        dictP.setValue(tf_telephone?.text, forKey: "telephone")
        dictP.setValue(tv_Address?.text, forKey: "address")
        
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.Contestant.Add, methodType: 1, forContent: 1, OnView: self, withParameters: dictP, IsShowLoader: true, dictImage: dictImg) { (dictJson, status) in
            if status == 1 {
                self.showAlertViewWithDuration(dictJson["message"] as! String, vc: self)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}

extension AddContestantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.flagIsUploadPic = true
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        self.imgView_User.image = image
        
        picker.dismiss(animated: false, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.flagIsUploadPic = false
        dismiss(animated: true, completion: nil)
    }
}

extension AddContestantViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Address" {
            textView.textColor = UIColor.white
            textView.text = ""
        }
        tv_Address.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.textColor = UIColor.white
            textView.text = "Address"
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.autocorrectionType = .no
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        let currentCharacterCount = tv_Address?.text?.count ?? 0
        let newLength = currentCharacterCount + text.count - range.length
        if(newLength <= ValidationConstants.MaxDescriptionLimit) {
            return true
        } else {
            return false
        }
    }
}
