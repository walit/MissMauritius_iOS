//
//  PastWinnerDetailViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 16/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class PastWinnerDetailViewController: UIViewController {

    var obPastWinner = PastWinnerModel()
    
    @IBOutlet weak var view_Content: UIView!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var imgView_User: UIImageView!
    
    @IBOutlet weak var tf_Height: UITextField!
    @IBOutlet weak var tf_Qualification: UITextField!
    @IBOutlet weak var tf_FullName: UITextField!
    @IBOutlet weak var tf_Occupation: UITextField!
    @IBOutlet weak var tf_Talent: UITextField!
    @IBOutlet weak var tf_SportPracticed: UITextField!
    @IBOutlet weak var tf_Ambition: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tf_Height.setLeftPaddingPoints(10.0)
        tf_Qualification.setLeftPaddingPoints(10.0)
        tf_FullName.setLeftPaddingPoints(10.0)
        tf_Occupation.setLeftPaddingPoints(10.0)
        tf_Talent.setLeftPaddingPoints(10.0)
        tf_SportPracticed.setLeftPaddingPoints(10.0)
        tf_Ambition.setLeftPaddingPoints(10.0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tf_FullName.text = obPastWinner.fullName
        tf_Height.text = obPastWinner.height
        tf_Qualification.text = obPastWinner.qualification
        tf_Occupation.text = obPastWinner.occupation
        tf_Talent.text = obPastWinner.talent
        tf_SportPracticed.text = obPastWinner.sportsPractice
        tf_Ambition.text = obPastWinner.ambition
        imgView_User.sd_setImage(with: URL(string: (obPastWinner.imageUrl)!), placeholderImage: UIImage())
        view_Content.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: tf_Ambition.frame.size.height + 20)
        scrlView.contentSize = CGSize(width: ScreenSize.SCREEN_WIDTH
            , height: view_Content.frame.size.height)
        
    }
    
    override func viewWillLayoutSubviews() {
        
        view_Content.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: tf_Ambition.frame.origin.y + tf_Ambition.frame.size.height + 50)
        scrlView.contentSize = CGSize(width: ScreenSize.SCREEN_WIDTH
            , height: view_Content.frame.size.height)
        
    }
    
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
