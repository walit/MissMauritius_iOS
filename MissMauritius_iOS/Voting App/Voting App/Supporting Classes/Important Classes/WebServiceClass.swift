//
//  WebServiceClass.swift
//
//  Created by Gourav Joshi on 22/08/16.
//  Copyright © 2016 Gourav Joshi. All rights reserved.
//

import UIKit
import SVProgressHUD

class WebServiceClass: NSObject {

    static let sharedInstanceOfWebServiceClass = WebServiceClass()
    var responseStatus = Int()
    func getWebApiData(webService name: String, methodType mType: Int, forContent cType: Int, OnView vc: UIViewController, withParameters dictParams: NSMutableDictionary, IsShowLoader: Bool = true, dictImage:NSMutableDictionary = NSMutableDictionary(), callBack: @escaping ((_ resultantDictionary: NSDictionary, _ status: Int) -> Void)) {
        
        if MF.isInternetAvailable() {
            
            // Check if internet is available before proceeding further
           
            //    print("Internet connection available")
                // Go ahead and fetch your data from the internet
                // ...
                if IsShowLoader {
                    SVProgressHUD.show(withStatus: "Loading....")
                }
                let strUrl = NSString(format: "%@%@", Server.BaseURL, name) as String
            //    print("Url = \(strUrl)")
             //   print("\n\n params = \(dictParams)")
                
                let url = NSURL(string: strUrl as String)
                let boundary = "Boundary-\(UUID().uuidString)"
                let body = NSMutableData()
                let request = NSMutableURLRequest(url: url! as URL)
                request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
                
                if Preferences?.value(forKey: "isLogin") as? Bool == true {
                    let authToken =  Preferences?.value(forKey: "accessToken") as! String
                //    print("authToken = \(authToken)")
                    request.setValue(authToken, forHTTPHeaderField: "ACCESS-TOKEN")
                }
            
            if name == WebServiceName.UserManagement.Login {
                
             //   print("Firebase registration token: \( Preferences?.value(forKey: "FCMToken"))")
                
                if  Preferences?.value(forKey: "FCMToken") as? String != nil {
                    request.setValue(Preferences?.value(forKey: "FCMToken") as! String, forHTTPHeaderField: "FCM-TOKEN")
                }
            }
            
                if dictParams.count > 0 {
                    /**
                     Managing parameters and values except data files
                     */
                    for (key, value) in dictParams {
                        if key as! String != "fileKey" && key as! String != "fileData" && key as! String != "multiFiles" {
                            body.appendString(string: "--\(boundary)\r\n")
                            body.appendString(string:"Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                            body.appendString(string:"\(value)\r\n")
                        }
                    }
                }
                
                
                if let fileData = dictImage["fileData"] as? Data {
                    ///file data in multipart form
                    let fileKey = dictImage["fileKey"] as! String
                    if fileData.count > 0 {
                        let filename = "\(UUID().uuidString).png"
                        let mimetype = "application/octet-stream"
                        body.appendString(string: "--\(boundary)\r\n")
                        body.appendString(string: "Content-Disposition: form-data; name=\"\(fileKey)\"; filename=\"\(filename)\"\r\n")
                        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
                        body.append(fileData)
                        body.appendString(string: "\r\n")
                        body.appendString(string: "--\(boundary)--\r\n")
                    }
                     request.httpBody = body as Data
                } else {
                    if dictParams.count > 0 {
                        let jsonData = try? JSONSerialization.data(withJSONObject: dictParams, options: .prettyPrinted)
                        let jsonString = String(data: jsonData!, encoding: .utf8)!
                        print("jsonString = \(jsonString)")
                        request.httpBody = Data(jsonString.utf8)
                    }
                }
                
            //    print("request = \(request.debugDescription)")
                
                //request.httpBody = body as Data
                
                /**
                 Setting the content type
                 */
                self.setHTTPContentType(request: request, cType: cType, boundary: boundary)
                
                /**
                 Setting the method type
                 */
                self.setHTTPMethodType(request: request, mType: mType)
                /**
                 Here I am creating session data task object to fulfil the API request
                 */
                let dataTask = SESSION.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                    
                    if response == nil { /// Response fail to get
                        DispatchQueue.main.async(execute: {
                            print("error = \(error.debugDescription)")
                            SVProgressHUD.dismiss()
                            let alert = UIAlertController(title : "Network Error: Could not connect to server.", message : "Oops! Network was failed to process your request. Do you want to try again?", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default ,handler:nil))
                            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default ,handler:
                                {(action:UIAlertAction) in
                                    self.getWebApiData(webService: name, methodType: mType, forContent: cType, OnView: vc, withParameters: dictParams, callBack: { (dict, status)  in
                                        callBack(dict, status)
                                    })
                            }))
                            vc.present(alert, animated: true, completion: nil)
                        })
                    } else { /// Response made to get
                        if error != nil {
                            //handle error
                            if IsShowLoader {
                               // vc.showAlertViewWithDuration(ValidationMessages.strInternalError, vc: vc)
                            }
                        } else if let data = data {
                            do {
                                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]//[AnyHashable: Any]
                             //   print("json response = \(jsonObject)")
                                DispatchQueue.main.async(execute: {
                                    SVProgressHUD.dismiss()
                                })
                                DispatchQueue.main.async(execute: {  /// pass the response to destination View
                                    if (jsonObject as NSDictionary)["status"] as? String == "success" {
                                        self.responseStatus = 1
                                    } else {
                                        self.responseStatus = 0
                                    }
                                    
                                    if jsonObject["message"] as? String  == "Please Buy Vote" {
                                        self.responseStatus = 1
                                       
                                    }
                                    
                                    if self.responseStatus == 1  {
                                        callBack(jsonObject as NSDictionary, self.responseStatus)
                                    } else if (jsonObject as NSDictionary)["status"] as? String == "fail" && jsonObject["message"] as? String  == "Invalid Token" {
                                        MF.logoutAndClearAllSessionData()
                                        
                                    } else {
                                        ///If response code other than success
                                        vc.showAlertViewWithMessage(jsonObject["message"] as! String, vc: vc)
                                    }
                                })
                            } catch {
                                let str = String.init(data: data, encoding: .utf8)
                                print("str = \(String(format: "%@", str!))")
                                SVProgressHUD.dismiss()
                                if IsShowLoader {
                                    vc.showAlertViewWithDuration(ValidationMessages.serverCommError, vc: vc)
                                }
                            }
                        }
                    }
                })
                DispatchQueue.main.suspend()
                DispatchQueue.main.resume()
                dataTask.resume()
                SESSION.finishTasksAndInvalidate()
            
        } else {
            MF.ShowPopUpViewOn(viewController: vc, popUpType: PopUpType.Simple, message: ValidationMessages.strInternetIsNotAvailable)
        }
    }
    
    func uploadImageData(webService name: String, methodType mType: Int, forContent cType: Int, OnView vc: UIViewController, withParameters dictParams: NSMutableDictionary, IsShowLoader: Bool = true, callBack: @escaping ((_ resultantDictionary: NSDictionary, _ status: Int) -> Void)) {
        if MF.isInternetAvailable() {
          
                if IsShowLoader {
                    SVProgressHUD.show(withStatus: "Loading....")
                }
                let strUrl = NSString(format: "%@%@", Server.BaseURL, name) as String
                let url = NSURL(string: strUrl as String)
                let boundary = "Boundary-\(UUID().uuidString)"
                let body = NSMutableData()
                let request = NSMutableURLRequest(url: url! as URL)
                request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
                
                if Preferences?.value(forKey: "isLogin") as? Bool == true {
                    let authToken =  Preferences?.value(forKey: "accessToken") as! String
                    print("authToken = \(authToken)")
                    request.setValue(authToken, forHTTPHeaderField: "ACCESS-TOKEN")
                }
                
                if let fileData = dictParams["fileData"] as? Data {
                    ///file data in multipart form
                    let fileKey = dictParams["fileKey"] as! String
                    if fileData.count > 0 {
                        let filename = "\(UUID().uuidString).png"
                        let mimetype = "application/octet-stream"
                        body.appendString(string: "--\(boundary)\r\n")
                        body.appendString(string: "Content-Disposition: form-data; name=\"\(fileKey)\"; filename=\"\(filename)\"\r\n")
                        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
                        body.append(fileData)
                        body.appendString(string: "\r\n")
                        body.appendString(string: "--\(boundary)--\r\n")
                    }
                }
                
                 request.httpBody = body as Data
                /**
                 Setting the content type
                 */
                self.setHTTPContentType(request: request, cType: cType, boundary: boundary)
                
                /**
                 Setting the method type
                 */
                self.setHTTPMethodType(request: request, mType: mType)
                /**
                 Here I am creating session data task object to fulfil the API request
                 */
                let dataTask = SESSION.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                    
                    if response == nil { /// Response fail to get
                        DispatchQueue.main.async(execute: {
                            print("error = \(error.debugDescription)")
                            SVProgressHUD.dismiss()
                            let alert = UIAlertController(title : "Network Error: Could not connect to server.", message : "Oops! Network was failed to process your request. Do you want to try again?", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default ,handler:nil))
                            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default ,handler:
                                {(action:UIAlertAction) in
                                    self.getWebApiData(webService: name, methodType: mType, forContent: cType, OnView: vc, withParameters: dictParams, callBack: { (dict, status)  in
                                        callBack(dict, status)
                                    })
                            }))
                            vc.present(alert, animated: true, completion: nil)
                        })
                    } else { /// Response made to get
                        if error != nil {
                            //handle error
                            if IsShowLoader {
                                // vc.showAlertViewWithDuration(ValidationMessages.strInternalError, vc: vc)
                            }
                        } else if let data = data {
                            do {
                                let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]//[AnyHashable: Any]
                                print("json response = \(jsonObject)")
                                DispatchQueue.main.async(execute: {
                                    SVProgressHUD.dismiss()
                                })
                                DispatchQueue.main.async(execute: {  /// pass the response to destination View
                                    if (jsonObject as NSDictionary)["status"] as? String == "success" {
                                        self.responseStatus = 1
                                    } else {
                                        self.responseStatus = 0
                                    }
                                    
                                    if jsonObject["message"] as? String  == "Please Buy Vote" {
                                        self.responseStatus = 1
                                        
                                    }
                                    
                                    if self.responseStatus == 1  {
                                        callBack(jsonObject as NSDictionary, self.responseStatus)
                                    } else if (jsonObject as NSDictionary)["status"] as? String == "fail" && jsonObject["message"] as? String  == "Invalid Token" {
                                        MF.logoutAndClearAllSessionData()
                                        
                                    } else {
                                        ///If response code other than success
                                        vc.showAlertViewWithMessage(jsonObject["message"] as! String, vc: vc)
                                    }
                                })
                            } catch {
                                let str = String.init(data: data, encoding: .utf8)
                                print("str = \(String(format: "%@", str!))")
                                SVProgressHUD.dismiss()
                                if IsShowLoader {
                                    vc.showAlertViewWithDuration(ValidationMessages.serverCommError, vc: vc)
                                }
                            }
                        }
                    }
                })
                DispatchQueue.main.suspend()
                DispatchQueue.main.resume()
                dataTask.resume()
                SESSION.finishTasksAndInvalidate()
        }
    }
    
    
    private func setHTTPMethodType(request: NSMutableURLRequest, mType: Int) {
        switch mType {
        case 1:
            request.httpMethod = MethodType.Post
            break
        case 2:
            request.httpMethod = MethodType.Get
            break
        case 3:
            request.httpMethod = MethodType.Put
            break
        default:
            break
        }
    }

    private func setHTTPContentType(request: NSMutableURLRequest, cType: Int, boundary: String) {
        switch cType {
        case 1:
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            break
        case 2:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            break
        case 3:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            break
        default:
            break
        }
    }
    
}
