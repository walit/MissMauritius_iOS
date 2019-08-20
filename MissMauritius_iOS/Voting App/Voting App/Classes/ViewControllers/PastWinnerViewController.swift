//
//  GalleryViewController.swift
//  Voting App
//
//  Created by Rupesh Chhabra on 14/08/19.
//  Copyright © 2019 Gourav Joshi. All rights reserved.
//

import UIKit

class PastWinnerViewController: UIViewController {

    var arrPastWinner:[PastWinnerModel]? = [PastWinnerModel]()
    
    @IBOutlet weak var colView: UICollectionView!
    @IBAction func btn_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPastWinnerList()
    }

    func getPastWinnerList() {
        OB_WEBSERVICE.getWebApiData(webService: WebServiceName.Common.PastWinners, methodType: 2, forContent: 3, OnView: self, withParameters: NSMutableDictionary()) { (dictJson, status) in
            if status == 1 {
                
                if let arr = dictJson["data"] as? NSArray {
                    for i in 0..<arr.count {
                        let obGal:PastWinnerModel? = PastWinnerModel()
                        obGal?.initWith(dict: arr[i] as? NSDictionary)
                        self.arrPastWinner?.append(obGal!)
                    }
                }
                self.colView.reloadData()
            }
        }
    }
}

extension PastWinnerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if DeviceType.IS_IPHONE_5 {
            return CGSize(width: (ScreenSize.SCREEN_WIDTH ) / 2, height: 210.0)
        } else {
            return CGSize(width: (ScreenSize.SCREEN_WIDTH ) / 2, height: 250.0)
        }
        //return CGSize(width: (ScreenSize.SCREEN_WIDTH ) / 2, height: (ScreenSize.SCREEN_WIDTH ) / 2 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrPastWinner!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryViewCell", for: indexPath) as! GalleryViewCell
        cell.setPastWinnerData(obGal:arrPastWinner?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MainStoryBoard.instantiateViewController(withIdentifier: "PastWinnerDetailViewController") as! PastWinnerDetailViewController
        vc.obPastWinner = (self.arrPastWinner?[indexPath.row])!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
