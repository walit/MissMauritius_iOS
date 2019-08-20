//
//  Alertview.swift
//  Audit
//
//  Created by Mac on 10/9/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit

class Alertview {
    
    class func ShowAlertView(title: String, message: String, controller: UIViewController, okHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
            if okHandler != nil {
                okHandler!()
            }
        }
        alertController.addAction(dismissAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
