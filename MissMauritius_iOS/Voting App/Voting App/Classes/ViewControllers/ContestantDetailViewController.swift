//
//  ContestantDetailViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 14/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class ContestantDetailViewController: UIViewController {
    var intContestantId = Int()
    
    @IBOutlet weak var view_Content: UIView!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var imgView_User: UIImageView!
    
    @IBOutlet weak var tf_DOB: UITextField!
    @IBOutlet weak var tf_Age: UITextField!
    @IBOutlet weak var tf_FullName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tf_FullName.setLeftPaddingPoints(10.0)
        tf_DOB.setLeftPaddingPoints(10.0)
        tf_Age.setLeftPaddingPoints(10.0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getContestantDetails()
    }

    override func viewWillLayoutSubviews() {
        view_Content.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: tf_DOB.frame.size.height + 50)
        scrlView.contentSize = CGSize(width: ScreenSize.SCREEN_WIDTH
            , height: view_Content.frame.size.height)
    }

    func getContestantDetails() {
        let strApiName = String(format: "%@?contestant_id=%d", WebServiceName.Contestant.Detail, intContestantId)
        
        OB_WEBSERVICE.getWebApiData(webService: strApiName, methodType: 2, forContent: 3, OnView: self, withParameters: NSMutableDictionary()) { (dictJson, status) in
            if status == 1 {
                if let imgUrl = (dictJson["data"] as! NSDictionary)["image"] as? String {
                     self.imgView_User.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage())
                }

                self.tf_FullName.text = (dictJson["data"] as! NSDictionary)["full_name"] as? String
                self.tf_DOB.text = (dictJson["data"] as! NSDictionary)["date_of_birth"] as? String
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                let date = dateFormatter.date(from:(dictJson["data"] as! NSDictionary)["date_of_birth"] as! String)!
                
                let calendar = Calendar.current
                let age = calendar.dateComponents([.year], from: date, to: Date())
                self.tf_Age.text = String(format:" %d", age.year!)
                /*
                let compDate = calendar.dateComponents([.year, .month, .day, .hour], from: date)

                let ageComponents = calendar.compare(compDate.date!, to: Date(), toGranularity: .year)//calendar.components(.CalendarUnitYear,    fromDate: compDate, toDate: Date(), options: nil)
                let age = ageComponents.rawValue */
                
            }
        }
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
