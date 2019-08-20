//
//  MenuViewProtocol.swift
//  Audit
//
//  Created by Rupesh Chhabra on 20/03/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

protocol MenuViewDelegate {
    func disMissView()
    func viewAccount()
    func redirectToSelectedIndex(indexPath: IndexPath)
}

extension MenuViewController: MenuViewDelegate {
    
    func viewAccount() {
            let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
        let vc = MainStoryBoard.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
        navigationController.viewControllers.append(vc!)
        MF.animateViewNavigation(navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        kAppDelegate.window?.rootViewController = navigationController
        self.disMissView()
    }

    func disMissView() {
        var menuFrame = self.view.frame
        UIView.animate(withDuration: 0.40, delay: 0, options: [.curveEaseOut], animations: {
            menuFrame.origin.x = -menuFrame.width
            self.view.frame     = menuFrame
        }) { (compelete) in
            self.view.removeFromSuperview()
            if DeviceType.IS_IPHONE_4_OR_LESS {
                self.parent?.parent?.dismiss(animated: true, completion: nil)
                self.dismiss(animated: false, completion: nil)
            } else {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    func redirectToSelectedIndex(indexPath: IndexPath) {
        let navigationController = kAppDelegate.window?.rootViewController as! UINavigationController
        
        if MF.setUpMenuContent()[indexPath.row].name == MenuItems.Profile {
            if (Preferences?.bool(forKey: "isLogin"))! {
            
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
            navigationController.viewControllers.append(vc!)
            MF.animateViewNavigation(navigationController: navigationController)
            navigationController.isNavigationBarHidden = true
            kAppDelegate.window?.rootViewController = navigationController
                self.disMissView()
            } else {
                self.showAlertViewWithDuration("Please login first", vc: self)
            }
        } else if MF.setUpMenuContent()[indexPath.row].name == MenuItems.Event {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "EventListViewController") as? EventListViewController
            navigationController.viewControllers.append(vc!)
            MF.animateViewNavigation(navigationController: navigationController)
            navigationController.isNavigationBarHidden = true
            kAppDelegate.window?.rootViewController = navigationController
            self.disMissView()
        } else if MF.setUpMenuContent()[indexPath.row].name == MenuItems.PastWinner {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "PastWinnerViewController") as? PastWinnerViewController
            navigationController.viewControllers.append(vc!)
            MF.animateViewNavigation(navigationController: navigationController)
            navigationController.isNavigationBarHidden = true
            kAppDelegate.window?.rootViewController = navigationController
            self.disMissView()
        } else if MF.setUpMenuContent()[indexPath.row].name == MenuItems.Gallery {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController
            navigationController.viewControllers.append(vc!)
            MF.animateViewNavigation(navigationController: navigationController)
            navigationController.isNavigationBarHidden = true
            kAppDelegate.window?.rootViewController = navigationController
            self.disMissView()
        } else if MF.setUpMenuContent()[indexPath.row].name == MenuItems.Sponsor {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "SponsorListViewController") as? SponsorListViewController
            navigationController.viewControllers.append(vc!)
            MF.animateViewNavigation(navigationController: navigationController)
            navigationController.isNavigationBarHidden = true
            kAppDelegate.window?.rootViewController = navigationController
            self.disMissView()
        } else if MF.setUpMenuContent()[indexPath.row].name == MenuItems.Committee {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "CommitteeMemberViewController") as? CommitteeMemberViewController
            navigationController.viewControllers.append(vc!)
            MF.animateViewNavigation(navigationController: navigationController)
            navigationController.isNavigationBarHidden = true
            kAppDelegate.window?.rootViewController = navigationController
            self.disMissView()
        } else if MF.setUpMenuContent()[indexPath.row].name == MenuItems.Notification {
            
          //  if (Preferences?.bool(forKey: "isLogin"))! {
                let vc = MainStoryBoard.instantiateViewController(withIdentifier: "NotificationListViewController") as? NotificationListViewController
                navigationController.viewControllers.append(vc!)
                MF.animateViewNavigation(navigationController: navigationController)
                navigationController.isNavigationBarHidden = true
                kAppDelegate.window?.rootViewController = navigationController
                self.disMissView()
         //   } else {
           //     self.showAlertViewWithDuration("Please login first", vc: self)
          //  }
        } else if MF.setUpMenuContent()[indexPath.row].name == MenuItems.AboutUs {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "WebContentViewController") as? WebContentViewController
            vc?.strType = MenuItems.AboutUs
            vc?.strLink = "http://missmauritius.walit.net/"
            navigationController.viewControllers.append(vc!)
            MF.animateViewNavigation(navigationController: navigationController)
            navigationController.isNavigationBarHidden = true
            kAppDelegate.window?.rootViewController = navigationController
            self.disMissView()
        } else if MF.setUpMenuContent()[indexPath.row].name == MenuItems.ContactUs {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController
            navigationController.viewControllers.append(vc!)
            MF.animateViewNavigation(navigationController: navigationController)
            navigationController.isNavigationBarHidden = true
            kAppDelegate.window?.rootViewController = navigationController
            self.disMissView()
        }
        //self.disMissView()
    }
    
}
