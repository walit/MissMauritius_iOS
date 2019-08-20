//
//  BuyVotesViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 24/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class BuyVotesViewController: UIViewController {

    var arrPlanList:[PlanModel]? = [PlanModel]()
    var contestantId = Int()
    var intVote = Int()
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var lbl_VoteRemaining: UILabel!
    @IBOutlet weak var lbl_UserName: UILabel!
    @IBOutlet weak var imgView_User: UIImageView!
    
    @IBAction func btn_ContestantDetails(_ sender: Any) {
        let vc = MainStoryBoard.instantiateViewController(withIdentifier: "ContestantDetailViewController") as! ContestantDetailViewController
        vc.intContestantId = contestantId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btn_VoteNow(_ sender: Any) {
        
        if !(Preferences?.bool(forKey: "isLogin"))! {
         //   self.showAlertViewWithDuration("Please login and then voting", vc: self)
                let alert = UIAlertController(title: "", message: "Please login and then voting", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title:"Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
                    MF.logoutAndClearAllSessionData()
                }
            
                alert.addAction(okButton)
            
                self.present(alert, animated: true, completion: nil)
        } else {
            let strApiName = String(format: "%@?contestant_id=%d", WebServiceName.Contestant.Voting, contestantId)
            OB_WEBSERVICE.getWebApiData(webService: strApiName, methodType: 2, forContent: 3, OnView: self, withParameters: NSMutableDictionary()) { (dictJson, status) in
                if status == 1 {
                    MF.ShowPopUpViewOn(viewController: self, popUpType: PopUpType.SimpleAction, message: dictJson["message"] as! String)
                }
            }
        }
    }
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // initPlanData()
        if DeviceType.IS_IPHONE_5 {
            lbl_UserName.font = UIFont.systemFont(ofSize: 12.0)
            lbl_VoteRemaining.font = UIFont.systemFont(ofSize: 12.0)
        }
        
        colView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        arrPlanList = [PlanModel]()
        getVotePriceData()
    }
    
    func getVotePriceData() {
        //VotePrice
        let ApiName = String(format: "%@?contestant_id=%d", WebServiceName.GetVotePrice, contestantId)
        OB_WEBSERVICE.getWebApiData(webService:ApiName , methodType: 2, forContent: 3, OnView: self, withParameters: NSMutableDictionary()) { (dictJson, status) in
            if status == 1 {
                self.lbl_UserName.text = (dictJson["data"] as! NSDictionary)["full_name"] as? String
                let imgUrl =  (dictJson["data"] as! NSDictionary)["image"] as? String
                self.imgView_User.sd_setImage(with: URL(string: imgUrl!), placeholderImage: UIImage.init(named: "img_user"))
                
                if let votecount = (dictJson["data"] as! NSDictionary)["vote_count"] as? String {
                   // if votecount != "0" {
                        self.intVote = Int(votecount)!
                        self.lbl_VoteRemaining.text = String(format: "You have %@ votes remaining", votecount)
                    //} else {
                      //  self.lbl_VoteRemaining.text = ""
                    //}
                }
                
                
                let arrVotePrice = (dictJson["data"] as! NSDictionary)["vote_price_list"] as! NSArray
                for i in 0..<arrVotePrice.count {
                    let obPlan: PlanModel? = PlanModel()
                    obPlan?.initWith(dict: arrVotePrice[i] as? NSDictionary)
                    self.arrPlanList?.append(obPlan!)
                }
                self.colView.reloadData()
            }
        }
    }
    
    func fetchPlanList() {
        
    }
    
    func initPlanData() {
        let o1 = PlanModel()
        o1.initWith(name: "Purchase for MUR 50", icon: "thumb-1+")
        arrPlanList?.append(o1)
        
        let o2 = PlanModel()
        o2.initWith(name: "Purchase for MUR 450", icon: "thumb-10+")
        arrPlanList?.append(o2)
        
        let o3 = PlanModel()
        o3.initWith(name: "Purchase for MUR 1150", icon: "thumb-25+")
        arrPlanList?.append(o3)
        
        let o4 = PlanModel()
        o4.initWith(name: "Purchase for MUR 2350", icon: "thumb-50+")
        arrPlanList?.append(o4)
        
        let o5 = PlanModel()
        o5.initWith(name: "Purchase for MUR 3350", icon: "thumb-75+")
        arrPlanList?.append(o5)
        
        let o6 = PlanModel()
        o6.initWith(name: "Purchase for MUR 4750", icon: "thumb-100+")
        arrPlanList?.append(o6)
    }
    
}

extension BuyVotesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if DeviceType.IS_IPHONE_5 {
            return CGSize(width: (ScreenSize.SCREEN_WIDTH ) / 2, height: (ScreenSize.SCREEN_WIDTH + 25) / 2)
        } else {
            return CGSize(width: (ScreenSize.SCREEN_WIDTH ) / 2, height: (ScreenSize.SCREEN_WIDTH + 5) / 2)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPlanList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanCell", for: indexPath) as! PlanCell
        cell.delegate = self
        cell.index = indexPath.row
        cell.setVotePlanData(ob: arrPlanList?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension BuyVotesViewController: PlanDelegate {
    func buyVote(index: Int) {
        if !(Preferences?.bool(forKey: "isLogin"))! {
            //   self.showAlertViewWithDuration("Please login and then voting", vc: self)
            let alert = UIAlertController(title: "", message: "First login ", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title:"Ok", style: UIAlertAction.Style.default) { (UIAlertAction) in
                MF.logoutAndClearAllSessionData()
            }
            
            alert.addAction(okButton)
            
            self.present(alert, animated: true, completion: nil)
        } else  {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "PaymentOptionViewController") as! PaymentOptionViewController
            vc.obPlan = (arrPlanList?[index])!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension BuyVotesViewController: PopUpDelegate {
    func actionOnOk() {
       // getVotePriceData()
        arrPlanList = [PlanModel]()
        getVotePriceData()
        
        /*
        if intVote > 0 {
            lbl_VoteRemaining.alpha = 1.0
            self.lbl_VoteRemaining.text = String(format: "You have %d votes remaining", intVote - 1)
            if intVote - 1 == 0 {
                lbl_VoteRemaining.alpha = 0.0
            }
        } else {
            lbl_VoteRemaining.alpha = 0.0
        } */
        
    }
}
