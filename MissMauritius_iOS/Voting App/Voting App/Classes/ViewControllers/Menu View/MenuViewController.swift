//
//  MenuViewController.swift
//  Individual App
//
//  Created by Rupesh Chhabra on 23/04/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBOutlet weak var btnWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btn_SignUp: UIButton!
    @IBOutlet weak var btn_Login: UIButton!
    @IBOutlet weak var btn_Logout: UIButton!
    @IBOutlet weak var logoutHeightConstraint: NSLayoutConstraint!
    @IBOutlet var view_AccountMgmt: UIView!
    var delegate:MenuViewDelegate?
    
    @IBOutlet var view_UserData: UIView!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var lbl_Mobile: UILabel!
    @IBOutlet weak var imgView_User: DesignableImage!
    @IBOutlet weak var view_Content: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView?.tableFooterView = UIView()
        delegate = self
        tblView.reloadData()

        // Do any additional setup after loading the view.
        setUpUserAndAccountView()
        setUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserData()
    }
   
    func setUpUserAndAccountView() {
        view_UserData.frame = view_Content.bounds
        view_Content.addSubview(view_UserData)
        view_UserData.alpha = 0.0
        
      /*  view_AccountMgmt.frame = view_Content.bounds
        view_Content.addSubview(view_AccountMgmt)
        view_AccountMgmt.alpha = 0.0 */
        
        btn_Login.roundCornersWithLayerMask(cornerRadii: 23.0, corners: [.topLeft,.bottomLeft], borderColor: UIColor.white)
       // btn_SignUp.roundCornersWithLayerMask(cornerRadii: 23.0, corners: [.topRight,.bottomRight], borderColor: UIColor.white)
        
    }
    
    func setUserData() {
        if (Preferences?.bool(forKey: "isLogin"))! {
            view_AccountMgmt.alpha = 0.0
            view_UserData.alpha = 1.0
            logoutHeightConstraint.constant = 50.0
            lbl_UserName.text = String(format: "%@ %@", obUser!.firstName!, (obUser?.lastName!)!)
            lbl_Mobile.text = obUser?.phone
            imgView_User.sd_setImage(with: URL(string: obUser!.imgUrl!), placeholderImage: UIImage.init(named: "img_user"))
            btn_Logout.alpha = 1.0
        } else {
            view_AccountMgmt.alpha = 1.0
            view_UserData.alpha = 0.0
            logoutHeightConstraint.constant = 00.0
            btn_Logout.alpha = 0.0
        }
    }
    
    func logout() {
     
        MF.ShowPopUpViewOn(viewController: self, popUpType: PopUpType.Action, title: "Logout!" , message: ValidationMessages.logout)
    }
    
    func clearUserAndAppSession() {
        
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.UserManagement.Logout, methodType: 2, forContent: 3, OnView: self, withParameters: NSMutableDictionary()) { (dictJson, status) in
            if status == 1 {
                self.delegate?.disMissView()
                MF.logoutAndClearAllSessionData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.showAlertViewWithDuration(ValidationMessages.logoutSuccessfully, vc: self)
                }
            }
        }
    }
    
    @IBAction func btn_Logout(_ sender: Any) {
        logout()
    }
    
    @IBAction func btn_HideMenu(_ sender: Any) {
        delegate?.disMissView()
    }

    @IBAction func btn_SignUp(_ sender: Any) {
         delegate?.disMissView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
              let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
            
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            navigationController.viewControllers.append(vc)
            MF.animateViewNavigation(navigationController: navigationController)
        }
    }
    @IBAction func btn_Login(_ sender: Any) {
        delegate?.disMissView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
              let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController.viewControllers.append(vc)
            MF.animateViewNavigation(navigationController: navigationController)
        }
    }
    
    @IBAction func btn_ViewProfile(_ sender: Any) {
        delegate?.viewAccount()
    }
}

extension MenuViewController: PopUpDelegate {
    func actionOnYes() {
        self.clearUserAndAppSession()
    }
    
    func actionOnNo() { }
}
