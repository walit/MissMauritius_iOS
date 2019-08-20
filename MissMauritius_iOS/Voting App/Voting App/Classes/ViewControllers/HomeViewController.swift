//
//  HomeViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 19/06/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit
import SpriteKit

class HomeViewController: UIViewController {

    var flagIsReloadHeader: Bool? = Bool()
    var bannerImgUrl = String()
    var bannerImgHeight:CGFloat = 120.0
    var isApplyNow = String()
    var arrContestantList:[ContestantModel]? = [ContestantModel]()
    var intContestantId = Int()
    @IBOutlet weak var colView: UICollectionView!
    @IBAction func btn_Menu(_ sender: Any) {
        MF.OpenMenuView(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    //    createStarLayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arrContestantList?.removeAll()
        arrContestantList = [ContestantModel]()
        
        self.colView.reloadData()
        getContestantList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      starFallingAnimation()
    }
    
    func starFallingAnimation() {
        
        let star1:CAEmitterLayer? = CAEmitterLayer()
        
        star1?.emitterPosition = CGPoint(x: 0, y: 65)
        star1?.emitterSize = CGSize(width: 10.0, height: 10.0)
        
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 25
        cell.velocity = 45
        cell.scale = 0.5
        cell.emissionRange = CGFloat.pi * 5.0
        cell.contents = UIImage(named: "star_y")!.cgImage
        
        star1?.emitterCells = [cell]
        
        view.layer.addSublayer(star1!)
        
        let star2:CAEmitterLayer? = CAEmitterLayer()
        star2?.emitterPosition = CGPoint(x: ScreenSize.SCREEN_WIDTH, y: 65)
        star2?.emitterSize = CGSize(width: 10.0, height: 10.0)
        
        let cell1 = CAEmitterCell()
        cell1.birthRate = 1
        cell1.lifetime = 25
        cell1.velocity = 45
        cell1.scale = 0.5
        cell1.emissionRange = CGFloat.pi * 5.0
        cell1.contents = UIImage(named: "star_g")!.cgImage
        
        star2?.emitterCells = [cell1]
        view.layer.addSublayer(star2!)
        
        let star3:CAEmitterLayer? = CAEmitterLayer()
        star3?.emitterPosition = CGPoint(x: ScreenSize.SCREEN_WIDTH / 2 - 50, y: 65)
        star3?.emitterSize = CGSize(width: 10.0, height: 10.0)
        
        let cell3 = CAEmitterCell()
        cell3.birthRate = 1
        cell3.lifetime = 25
        cell3.velocity = 45
        cell3.scale = 0.5
        cell3.emissionRange = CGFloat.pi * 5.0
        cell3.contents = UIImage(named: "star_white")!.cgImage
        
        star3?.emitterCells = [cell3]
        view.layer.addSublayer(star3!)
        
    }
    
    func getContestantList() {
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.Contestant.List, methodType: 2, forContent: 3, OnView: self, withParameters: NSMutableDictionary()) { (dictJson, status) in
            if status == 1 {
                
                self.isApplyNow = dictJson["apply_contestant"] as! String
                self.bannerImgUrl = dictJson["banner_image"] as! String
                for i in 0..<(dictJson["data"] as! NSArray).count {
                    let obCont:ContestantModel? = ContestantModel()
                    obCont?.initWith(dict: (dictJson["data"] as! NSArray)[i] as? NSDictionary)
                    self.arrContestantList?.append(obCont!)
                }
                /**/
                self.colView.reloadData()
            }
        }
    }
   
    func voteForContestant(contestantId: Int) {
    }
    // MARK: - Navigation
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderClass", for: indexPath)
        
        let imgViewBanner = UIImageView.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: headerView.frame.size.height))
        
        imgViewBanner.sd_setImage(with: URL(string: bannerImgUrl)) { (img, error, imgType, url) in
            if img != nil {
                if !self.flagIsReloadHeader! {
                var imgNew = UIImage()
                print("img size = \(MF.resizeImageWithDeviceSize(image: img!, targetSize: CGSize(width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)))")
                
                imgViewBanner.image = img
                imgNew = MF.resizeImageWithDeviceSize(image: img!, targetSize: CGSize(width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT))
                
                self.bannerImgHeight = (imgNew.size.height)
                
                    self.flagIsReloadHeader = true
                    self.colView.reloadData()
                }
            }
        }

        if DeviceType.IS_IPHONE_6P {
            imgViewBanner.contentMode = .scaleToFill
        } else {
            imgViewBanner.contentMode = .scaleAspectFit
        }
      
        headerView.addSubview(imgViewBanner)
        if isApplyNow == "1" {
            
            var btnHeight: CGFloat = 48.0
            var imgHeight: CGFloat = 40.0
            var cRadius: CGFloat = 24.0
            var imcRadius: CGFloat = 20.0
            if DeviceType.IS_IPHONE_5 {
                btnHeight = 40.0
                cRadius = 20.0
                imgHeight = 32.0
                imcRadius = 16.0
            }
            
            let btn_ApplyNow = UIButton.init(frame: CGRect(x: colView.frame.size.width / 4 - 25 , y: headerView.frame.size.height - 50, width: colView.frame.size.width / 2 + 50, height: btnHeight))
            let imgView = UIImageView.init(frame: CGRect(x: btn_ApplyNow.frame.origin.x + btn_ApplyNow.frame.size.width - 52  , y: btn_ApplyNow.frame.origin.y + 4, width: imgHeight, height: imgHeight))
            imgView.image = UIImage(named: "app_logo")
            imgView.backgroundColor = UIColor.black
            imgView.layer.cornerRadius = imcRadius
            imgView.clipsToBounds = true
            //  btn_ApplyNow.addRightImage(image: UIImage(named: "back_icon")!, offset: CGFloat(95.0))
            btn_ApplyNow.semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
            //btn_ApplyNow.center = headerView.center
            btn_ApplyNow.backgroundColor = CustomColors.themeColorYellow
            btn_ApplyNow.layer.cornerRadius = cRadius
            btn_ApplyNow.clipsToBounds = true
            btn_ApplyNow.setTitle("APPLY NOW", for: UIControl.State.normal)
            btn_ApplyNow.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            btn_ApplyNow.setTitleColor(UIColor.black, for: UIControl.State.normal)
            btn_ApplyNow.addTarget(self, action: #selector(applyNowAction(button:)), for: UIControl.Event.touchUpInside)
            headerView.addSubview(btn_ApplyNow)
            headerView.addSubview(imgView)
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //if DeviceType.IS_IPHONE_5 {
            return CGSize(width: collectionView.frame.width, height: self.bannerImgHeight)
        /*} else if DeviceType.IS_IPHONE_6P {
            return CGSize(width: collectionView.frame.width, height: 140.0)
        } else  {
            return CGSize(width: collectionView.frame.width, height: 120.0)
        } */
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if DeviceType.IS_IPHONE_5 {
            return CGSize(width: (ScreenSize.SCREEN_WIDTH ) / 2, height: 215)
        } else {
            return CGSize(width: (ScreenSize.SCREEN_WIDTH ) / 2, height: 235)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrContestantList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContestantCell", for: indexPath) as! ContestantCell
        cell.delegate = self
        cell.index = indexPath.row
        cell.setContestantData(obCont: arrContestantList?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MainStoryBoard.instantiateViewController(withIdentifier: "BuyVotesViewController") as! BuyVotesViewController
        vc.contestantId = (self.arrContestantList?[indexPath.row].contestantId)!
       // self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func applyNowAction(button: UIButton) {
        print("applied")
         let vc = MainStoryBoard.instantiateViewController(withIdentifier: "AddContestantViewController") as? AddContestantViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension HomeViewController: ContestantDelegate {
    func voteForContestant(index: Int) {
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "BuyVotesViewController") as! BuyVotesViewController
            vc.contestantId = (self.arrContestantList?[index].contestantId)!
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func likeContestant(index: Int) {
        
    }
    
}

extension HomeViewController: PopUpDelegate {
    func actionOnOk() {
        
            let vc = MainStoryBoard.instantiateViewController(withIdentifier: "BuyVotesViewController") as! BuyVotesViewController
            vc.contestantId = self.intContestantId
            self.navigationController?.pushViewController(vc, animated: true)
    }
}
