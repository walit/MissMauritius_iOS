//
//  ViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 18/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var lbl_Msg: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lbl_Msg.setDifferentColor(string: ThemeMessage, location: 0, length: 29)
    }

    @IBAction func btn_SignIn(_ sender: Any) {
        let vc = MainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_SignUp(_ sender: Any) {
      
    }
}

