//
//  AppDelegate.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 18/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var strDeviceToken: String = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
   //     UIViewController.
        application.statusBarStyle = .lightContent
        IQKeyboardManager.shared.enable = true
        checkUserIsLoginOrNot()
         registerForPushNotifications(application)
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    //MARK: Other Supporting FUnctions
    func checkUserIsLoginOrNot() {
        
        print("isLogin = \(Preferences?.bool(forKey: "isLogin"))")
        
        if Preferences?.object(forKey: "isLogin") != nil {
            if (Preferences?.bool(forKey: "isLogin"))! {
                do {
                    let unarchiveUserData: NSMutableDictionary = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData((Preferences?.object(forKey: "UserData") as! NSData) as Data) as! NSMutableDictionary
                      obUser?.initWith(dict: unarchiveUserData.mutableCopy() as! NSMutableDictionary)
                    
                    let home_vc = MainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    let nvc: UINavigationController = UINavigationController(rootViewController: home_vc)
                    nvc.navigationBar.isHidden = true
                    self.window?.rootViewController = nvc
                } catch let ex as Error {
                    /// If any error occured then consider as seeion expired
                    let home_vc = MainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    let nvc: UINavigationController = UINavigationController(rootViewController: home_vc)
                    nvc.navigationBar.isHidden = true
                    self.window?.rootViewController = nvc
                }
            }
        } else {
            let home_vc = MainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let nvc: UINavigationController = UINavigationController(rootViewController: home_vc)
            nvc.navigationBar.isHidden = true
            self.window?.rootViewController = nvc
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func registerForPushNotifications(_ application: UIApplication) {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert], completionHandler: {(granted, error) in
                print("is granted = \(granted)")
                if (granted)  {
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.registerForRemoteNotifications()
                    })
                } else {
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.registerForRemoteNotifications()
                    })
                }
            })
        } else {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    // MARK: Device Token Methods:
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        strDeviceToken=token
         Messaging.messaging().apnsToken = deviceToken
        print("strDeviceToken = \(strDeviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Device token for push notifications: FAIL -- ")
        print(error.localizedDescription)
    }
    
    //MARK: Push Notifications methods:
    /// This method will work when the app is in background and receives push notification
    func application( _ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                      fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      
        showNotificationMessage(dictND:  userInfo as NSDictionary)
        completionHandler(.newData)
    }
    
    @available(iOS 10.0, *)
    func application(_ application: UIApplication, didReceive notification: UNNotificationRequest) {
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //Handle the notification
        print("userInfo willPresent= \(notification.request.content.userInfo)")
        //  if flagIsInBackground {
        if Version.iOS10 {
            completionHandler(UNNotificationPresentationOptions.alert)
        } else if Version.iOS11 || Version.iOS12 {
            completionHandler([.sound, .alert])
        }
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //Handle the notification
        print("userInfo didReceive= \(response.notification.debugDescription)")
        /// SHow Alert here
      completionHandler()
    }
    
    /// This is the common function to manage the notification alert view, where the notification methods invokes it calls from there.
    func showNotificationMessage(dictND: NSDictionary){
        window?.rootViewController?.showAlertViewWithMessage(String(format: "%@", dictND["alert"] as! String), vc: (window?.rootViewController!)!)
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let fToken = String(format: "%@", fcmToken)
        
        Preferences?.setValue(fToken , forKey: "FCMToken")
        
     //   print("Firebase registration token: \( Preferences?.value(forKey: "FCMToken")!)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
}
